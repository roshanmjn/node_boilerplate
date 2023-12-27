const jwt = require("jsonwebtoken");
const { gmailToken } = require("../modules/email/email.global.service");
const { hasTokenExpired } = require("../utils/encrypter");
const { dbConnection } = require("../config/connection");
const { NotAuthorized, HttpException } = require("./errors");

// Custom middleware to verify JWT
function authenticateToken(req, res, next) {
    const token = req.cookies["access_token"] || req.headers["x-access-token"];
    if (!token) {
        return res.status(401).json({
            status: "error",
            message: "Authentication failed: Token missing",
        });
    }

    jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
        if (err) {
            if (err.name === "JsonWebTokenError") {
                return res.status(401).json({
                    status: "error",
                    message: "Authentication failed: Invalid token",
                });
            } else if (err.name === "TokenExpiredError") {
                return res.status(401).json({
                    status: "error",
                    message: "Authentication failed: Token expired",
                });
            } else {
                return res.status(500).json({
                    status: "error",
                    message: "Internal server error",
                });
            }
        }
        req.userId = decoded.id;
        next();
    });
}

async function authenticateGmailToken(req, res, next) {
    try {
        const mainUserAccessToken = req.cookies["access_token"] || req.headers["x-access-token"];
        const userId = jwt.decode(mainUserAccessToken).id;
        let gmailAccessToken = req.headers.authorization?.split(" ")[1];
        let expiryDate = req.headers.expiry_date;
        const authType = req.body.authType;
        // console.log({ gmailAccessToken, expiryDate });
        if (!authType) throw new HttpException(401, "Authentication failed: authType missing");
        if (authType === "GMAIL") {
            if (!gmailAccessToken || !expiryDate) {
                throw new HttpException(401, "Authentication failed: Gmail Token missing");
            }

            if (true) {
                console.log("\nRenewing expired gmail access token...\n");
                const conn = await dbConnection;
                let query = "SELECT smtp_password FROM mailaccountconfig WHERE user_id = ? AND type='GMAIL';";
                const [findUser] = await conn.query(query, [userId]);

                if (!!findUser && findUser.length === 0) {
                    throw new NotAuthorized();
                }
                if (findUser && findUser.length > 0) {
                    const requestNewAccessToken = await gmailToken(null, decodeURIComponent(atob(findUser[0].smtp_password)));
                    console.log("\n--New gmail token aquired\n");
                    req.headers.authorization = "Bearer " + requestNewAccessToken.accessToken;
                    req.headers.expiry_date = requestNewAccessToken.expiryDate;
                }
            }
        }
        // console.log({ newGmailToken: req.headers.authorization, newExpiry: req.headers.expiry_date });
        next();
    } catch (err) {
        next(err);
    }
}
module.exports = { authenticateToken, authenticateGmailToken };
