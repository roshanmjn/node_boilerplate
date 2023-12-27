const nodemailer = require("nodemailer");

const sendVerificationEmail = async (email, verificationLink) => {
    return new Promise((resolve, reject) => {
        const transporter = nodemailer.createTransport({
            host: process.env.MAIL_HOST,
            port: process.env.MAIL_PORT,
            secure: true,
            auth: {
                user: process.env.MAIL_USERNAME,
                pass: process.env.MAIL_PASSWORD,
            },
        });

        console.log(verificationLink);

        const mailOptions = {
            from: `${process.env.MAIL_FROM_ADDRESS} <${process.env.MAIL_USERNAME}>`,
            to: email,
            subject: "Email Verification",
            text: `Click the following link to verify your email: ${verificationLink}`,
            html: `<p>Click the following link to verify your email: <a href="${verificationLink}">${verificationLink}</a></p>`,
        };

        transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
                console.error(error);
                reject({
                    status: "failed",
                });
            } else {
                console.log("Email sent: " + info.response);
                resolve({
                    status: "success",
                    message: "Email sent to " + email,
                });
            }
        });
    });
};
module.exports = {
    sendVerificationEmail,
};
