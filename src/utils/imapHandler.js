const Imap = require("imap");
const { HttpException, NotAuthorized } = require("../middlewares/errors.js");
const { Base64Decode } = require("base64-stream");
const fs = require("fs");
const { dbConnection } = require("../config/connection.js");
const { gmailToken } = require("../modules/email/email.global.service.js");
const { hasTokenExpired } = require("./encrypter.js");

function _build_XOAuth2_token(user = "", access_token = "") {
    return Buffer.from([`user=${user}`, `auth=Bearer ${access_token}`, "", ""].join("\x01"), "utf-8").toString("base64");
}

/**
 * Creates an IMAP connection based on the provided parameters.
 * @param {string} host - The hostname or IP address of the mail server.
 * @param {number} port - The port number for the mail server connection.
 * @param {string} userEmail - The user's email address.
 * @param {string} credentials - The user's password or access token.
 * @param {string} authType - The type of authentication ('password' or 'oauth2').
 * @returns {Imap} - An instance of the Imap class representing the connection.
 * @throws {HttpException} Throws an HTTP exception if the authentication type is invalid.
 */
function imapConnection(host, port, userEmail, credentials, authType) {
    // console.log("imapConnection:", { host, port, userEmail, credentials, authType });
    console.log("\n-----------IMAP HANDLER-----------\n");
    let config = {
        host: host,
        port: port,
        tls: true,
        authTimeout: 10000,
        connTimeout: 20000,
        tls: {
            rejectUnauthorized: false, // Accept self-signed certificates
        },
        tlsOptions: {
            servername: "mail.byteperks.com",
            rejectUnauthorized: false, // Accept self-signed certificates
        },
        // debug: console.log,
    };

    if (authType === "password" || authType === "IMAP") {
        config.user = userEmail;
        config.password = credentials;
    } else if (authType === "oauth2" || authType === "GMAIL") {
        config.xoauth2 = _build_XOAuth2_token(userEmail, credentials);
    } else {
        throw new HttpException(400, "Invalid authentication type");
    }
    console.log({ config });
    return new Imap(config);
}

/**
 * Returns an IMAP Inbox based on the provided parameters.
 * @param {string} host - The hostname or IP address of the mail server.
 * @param {number} port - The port number for the mail server connection.
 * @param {string} userEmail - The user's email address.
 * @param {string} credentials - The user's password or access token.
 * @param {string} authType - The type of authentication ('password' or 'oauth2').
 * @param {string} toFetch - The mailbox to fetch (e.g. 'INBOX', 'Sent', 'Drafts', etc.).
 * @param {Number} page - The page number to fetch.
 * @returns {Promise<Array<Object>>} - Promise of data array objects.
 * @throws {HttpException} Throws an HTTP exception if the authentication type is invalid.
 */
function imapInbox(host, port, userEmail, credentials, authType, toFetch, page) {
    const mapFetch = {
        all: authType === "oauth2" ? "[Gmail]/All Mail" : "",
        draft: authType === "oauth2" ? "[Gmail]/Drafts" : "INBOX.Drafts",
        important: authType === "oauth2" ? "[Gmail]/Important" : "",
        sent: authType === "oauth2" ? "[Gmail]/Sent Mail" : "INBOX.Sent",
        spam: authType === "oauth2" ? "[Gmail]/Spam" : "INBOX.Spam",
        starred: authType === "oauth2" ? "[Gmail]/Starred" : "",
        trash: authType === "oauth2" ? "[Gmail]/Trash" : "INBOX.Trash",
        archive: authType === "oauth2" ? "" : "INBOX.Archive",
        junk: authType === "oauth2" ? "" : "INBOX.Junk",
    };
    if (toFetch) {
        mapFetch[toFetch] ? (toFetch = mapFetch[toFetch]) : (toFetch = "INBOX");
    }

    return new Promise((resolve, reject) => {
        let imap = imapConnection(host, port, userEmail, credentials, authType);

        const userProvidedPageNumber = page || 1;
        const limit = 20;

        console.log("-------START IMAP-------");
        imap.once("ready", function () {
            console.log(toFetch);
            imap.openBox(toFetch, true, function (err, box) {
                if (err) {
                    console.log(err);
                    imap.end();
                    return;
                }

                const totalMessages = box.messages.total;
                console.log(userEmail, ":", totalMessages);
                const totalPages = Math.ceil(totalMessages / limit);
                const requestedPageFromEnd = totalPages - userProvidedPageNumber + 1;
                const lastPageMessageCount = totalMessages % limit || limit;
                const offset = Math.max(0, (requestedPageFromEnd - 1) * limit - (limit - lastPageMessageCount));

                if (requestedPageFromEnd < 0 || requestedPageFromEnd > totalPages) {
                    imap.end();
                    return { message: "No more emails to fetch" };
                }

                let fetchRangeStart = offset + 1;
                let fetchRangeEnd = offset + limit;

                if (fetchRangeStart > totalMessages) {
                    fetchRangeStart = totalMessages - lastPageMessageCount + 1;
                    fetchRangeEnd = totalMessages;
                } else if (fetchRangeEnd > totalMessages) {
                    fetchRangeEnd = totalMessages;
                }
                const fetchRange = `${fetchRangeStart}:${fetchRangeEnd}`;
                console.log(fetchRange);

                const fetchOptions = {
                    bodies: "",
                    markSeen: false,
                    struct: true,
                };

                const fetch = imap.seq.fetch(fetchRange, fetchOptions);

                const emails = [];
                const attrub = [];
                const flags = [];
                const uid = [];
                fetch.on("message", function (msg, seqno) {
                    let data = "";
                    msg.on("body", function (stream) {
                        stream.on("data", function (chunk) {
                            data += chunk.toString("utf8");
                        });
                    });

                    msg.once("end", function () {
                        const parsedEmail = {};
                        parsedEmail.body = data;
                        parsedEmail.seqno = seqno;
                        parsedEmail.info = Imap.parseHeader(data);
                        emails.push(parsedEmail);
                    });
                    msg.once("attributes", function (attrs) {
                        var attachments = findAttachmentParts(attrs.struct);
                        console.log("uid", attrs.uid);
                        uid.push(attrs.uid);
                        let atchmnt = [];
                        for (var i = 0, len = attachments.length; i < len; ++i) {
                            var attachment = attachments[i];
                            console.log("attachment", attachment);

                            const filename = attachment.params == null ? new Date().getTime().toString() : attachment.params.name;
                            const size = attachment.size;
                            const email = userEmail;
                            let folder = Imap.parseHeader(data).date;
                            if (folder[0]) {
                                folder = folder[0];
                                folder = new Date(folder);
                                folder = folder.getTime();
                            }
                            console.log(folder);
                            atchmnt.push({
                                filename,
                                size,
                                type: attachment.type,
                                url: `attachments/${folder}/${filename}`,
                            });

                            var f = imap.fetch(attrs.uid, {
                                //do not use imap.seq.fetch here
                                bodies: [attachment.partID],
                                struct: true,
                            });
                            //build function to process attachment message
                            f.on("message", buildAttMessageFunction(attachment, folder, email));
                        }
                        attrub.push(atchmnt);
                        flags.push(attrs.flags);
                    });
                });

                fetch.once("end", function () {
                    imap.end();
                    let data = [];
                    let index = 0;
                    processNodes(emails, data, index);
                    function processNodes(nodes, data, index = 0) {
                        nodes.forEach((node, idx) => {
                            // console.log(Object.keys(node));
                            const nodeIndex = index ? `${index}-${idx}` : `${idx}`; // Create the index
                            let parentI = nodeIndex.split("-")[0];
                            if (!data[parentI]) {
                                data[parentI] = {};
                                data[parentI].info = {};
                                data[parentI].info.date = node.info.date[0];
                                data[parentI].info.from = node.info.from[0];
                                data[parentI].info.subject = node.info.subject ? node.info.subject[0] : "";
                                data[parentI].info.to = node.info.to ? node.info.to[0] : "";
                                data[parentI].seqno = node.seqno;
                                data[parentI].flags = flags[parentI];
                                data[parentI].info.uid = uid[parentI];
                                data[parentI].attachments = attrub[parentI];
                                data[parentI].body = node.body;
                            }
                        });
                    }
                    if (data.length) {
                        console.log(data.length);
                        resolve(data.reverse());
                    }
                });

                fetch.once("error", function (err) {
                    console.log(err);
                    imap.end();
                    reject({ error: "Fetch error", details: err });
                });
            });
        });

        imap.once("error", function (err) {
            console.log(err);
            reject({ error: "IMAP error" });
        });

        imap.connect();

        function buildAttMessageFunction(attachment, folder, email) {
            var filename = attachment.params == null ? new Date().getTime().toString() : attachment.params.name;
            var encoding = attachment.encoding;

            return function (msg, seqno) {
                var prefix = "(#" + seqno + ") ";
                msg.on("body", function (stream, info) {
                    //Create a write stream so that we can stream the attachment to file;
                    // console.log(prefix + 'Streaming this attachment to file', filename, info);
                    const filePath = `./attachments/${email}/${folder}/${filename}`;
                    try {
                        fs.mkdirSync(`./attachments/${email}/${folder}`, {
                            recursive: true,
                        });
                    } catch (err) {
                        console.error(prefix + "Error creating directories:", err);
                        return;
                    }

                    var writeStream = fs.createWriteStream(filePath);
                    writeStream.on("finish", function () {
                        // console.log(prefix + 'Done writing to file %s', filename);
                    });

                    //stream.pipe(writeStream); this would write base64 data to the file.
                    //so we decode during streaming using
                    if (toUpper(encoding) === "BASE64") {
                        //the stream is base64 encoded, so here the stream is decode on the fly and piped to the write stream (file)
                        stream.pipe(new Base64Decode()).pipe(writeStream);
                    } else {
                        //here we have none or some other decoding streamed directly to the file which renders it useless probably
                        stream.pipe(writeStream);
                    }
                });
                msg.once("end", function () {
                    // console.log(prefix + 'Finished attachment %s', filename);
                });
            };
        }

        function toUpper(thing) {
            return thing && thing.toUpperCase ? thing.toUpperCase() : thing;
        }

        function findAttachmentParts(struct, attachments) {
            attachments = attachments || [];
            struct.forEach((i) => {
                if (Array.isArray(i)) findAttachmentParts(i, attachments);
                else if (i.disposition && ["INLINE", "ATTACHMENT"].indexOf(toUpper(i.disposition.type)) > -1) {
                    attachments.push(i);
                }
            });
            return attachments;
        }
    });
}

async function hasGmailTokenExpired(encodedUserEmail, expiryDate, userId) {
    try {
        console.log({ encodedUserEmail, expiryDate, userId });
        if (expiryDate && hasTokenExpired(Number(expiryDate))) {
            console.log("access token expired, requesting new one");
            const conn = await dbConnection;
            let query = `
                SELECT smtp_password 
                FROM mailaccountconfig 
                WHERE imap_username=? AND user_id = ? AND type='GMAIL'`;
            const [findUser] = await conn.query(query, [encodedUserEmail, userId]);
            console.log(findUser);

            if (!findUser) {
                throw new NotAuthorized();
            }
            if (findUser && findUser.length > 0) {
                const requestNewAccessToken = await gmailToken(null, decodeURIComponent(atob(findUser[0].smtp_password)));
                return { expired: true, gmailAccessToken: requestNewAccessToken.accessToken, expiryDate: requestNewAccessToken.expiryDate };
            }
        }
        return { expired: false };
    } catch (error) {
        throw new HttpException(401, error.message);
    }
}
module.exports = { imapConnection, imapInbox, hasGmailTokenExpired };
