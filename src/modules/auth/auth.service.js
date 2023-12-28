const httpStatus = require("http-status");
const { HttpException } = require("../../middlewares/errors.js");
const { dbConnection } = require("../../config/connection.js");
const { sendVerificationEmail } = require("../../utils/contact.js");
require("dotenv").config();

const {
    decrypt,
    encrypt,
    decodeBase64Values,
    jwtSign,
    jwtDecode,
    jwtRefreshDecode,
    jwtSecretVerifySign,
    jwtRefreshSign,
    jwtResetVerifyDecode,
} = require("../../utils/encrypter.js");

const login = async (email, password) => {
    try {
        const conn = await dbConnection;

        const query = `
        SELECT users.*, mailaccountconfig.default_email AS default_email, mailaccountconfig.imap_username AS mailemail,mailaccountconfig.type AS mail_type,
        mailaccountconfig.smtp_password AS mail_password
        FROM users
        LEFT JOIN mailaccountconfig ON users.id = mailaccountconfig.user_id
        WHERE users.email = ?;
      `;

        const [findUser] = await conn.query(query, [btoa(encodeURIComponent(email))]);
        console.log(findUser);
        if (!findUser || findUser.length < 1) {
            return { message: "User account does not exist!" };
        }

        const decoded_password = await decrypt(password, findUser[0].password);
        if (!decoded_password) {
            return { message: "Invalid password!" };
        }

        const decoded = decodeBase64Values({
            id: findUser[0].id,
            first_name: findUser[0].first_name,
            last_name: findUser[0].last_name,
            email: findUser[0].email,
            google_id: findUser[0].google_id,
            facebook_id: findUser[0].facebook_id,
            token: findUser[0].token,
        });

        if (findUser[0].status === 0) {
            verifyEmailToken();
            return { message: "Please verify your email first!" };
        }

        const refreshToken = jwtRefreshSign({
            id: decoded.id,
            first_name: decoded.first_name,
            last_name: decoded.last_name,
            email: decoded.email,
        });

        const token = btoa(encodeURIComponent(refreshToken));
        const updateQuery = `UPDATE users SET token = ? WHERE id = ?`;
        const [updateResult] = await conn.query(updateQuery, [token, decoded.id]);

        if (updateResult.affectedRows !== 1) {
            console.error("Failed to save the refresh token. No rows were affected.");
            return { message: "Failed to save the refresh token." };
        }

        const accessToken = jwtSign({
            id: decoded.id,
            first_name: decoded.first_name,
            last_name: decoded.last_name,
            email: decoded.email,
        });

        return {
            id: decoded.id,
            first_name: decoded.first_name,
            last_name: decoded.last_name,
            email: decoded.email,
            image: findUser[0].image,
            token: accessToken,
            refreshToken: refreshToken,
        };
    } catch (error) {
        console.error("Error during login:", error);
        throw new HttpException(httpStatus.BAD_REQUEST, "Failed to save the refresh token.");
    }
};

const refreshAuth = async (refreshToken) => {
    console.log("Received refresh token:", refreshToken);

    if (!refreshToken) {
        console.log("Refresh token not found, login again");
        return { message: "Refresh token not found, login again" };
    }

    try {
        const conn = await dbConnection;
        const token = btoa(encodeURIComponent(refreshToken));
        const user_id = jwtRefreshDecode(refreshToken).id;
        // console.log('Encoded token:', token);

        let query = "SELECT * FROM users WHERE token = ? AND id=?";
        const [findUser] = await conn.query(query, [token, user_id]);
        // console.log('User found:', findUser);

        // Check if the refresh token is valid
        if (findUser.length === 0) {
            // console.log('Invalid refresh token');
            return { message: "Invalid refresh token" };
        }

        const jwtredeconde = jwtRefreshDecode(refreshToken);

        if (!jwtredeconde) {
            // console.log('Invalid refresh token');
            return { message: "Invalid refresh token" };
        }

        const decoded = decodeBase64Values({
            id: findUser[0].id,
            first_name: findUser[0].first_name,
            last_name: findUser[0].last_name,
            email: findUser[0].email,
        });

        const newRefreshToken = jwtRefreshSign({
            id: decoded.id,
            first_name: decoded.first_name,
            last_name: decoded.last_name,
            email: decoded.email,
        });

        const newAccessToken = jwtSign({
            id: decoded.id,
            first_name: decoded.first_name,
            last_name: decoded.last_name,
            email: decoded.email,
        });

        const updateQuery = "UPDATE users SET token = ? WHERE id = ?";
        const [updateResult] = await conn.query(updateQuery, [btoa(encodeURIComponent(newRefreshToken)), decoded.id]);

        // Check if the refresh token was successfully updated
        if (updateResult.affectedRows !== 1) {
            console.error("Failed to save the refresh token. No rows were affected.");
            return { message: "Failed to save the refresh token." };
        }

        // console.log('Refresh token successfully updated');

        return {
            id: decoded.id,
            first_name: decoded.first_name,
            last_name: decoded.last_name,
            email: decoded.email,
            token: newAccessToken,
            refreshToken: newRefreshToken,
        };
    } catch (error) {
        console.error("Error during refreshAuth:", error);
        throw new HttpException(httpStatus.BAD_REQUEST, "Failed to refresh authentication.");
    }
};

const logout = async (refreshToken) => {
    // console.log('Received refresh token:', refreshToken);

    if (!refreshToken) {
        // console.log('Refresh token not found, login again');
        return { message: "Refresh token not found, login again" };
    }

    try {
        const conn = await dbConnection;
        const token = btoa(encodeURIComponent(refreshToken));
        // console.log('Encoded token:', token);

        let query = "SELECT * FROM users WHERE token = ?";
        const [findUser] = await conn.query(query, [token]);
        // console.log('User found:', findUser);

        // Check if the refresh token is valid
        if (findUser.length === 0) {
            // console.log('Invalid refresh token');
            return { message: "Invalid refresh token" };
        }

        const jwtredeconde = jwtRefreshDecode(refreshToken);

        if (!jwtredeconde) {
            // console.log('Invalid refresh token');
            return { message: "Invalid refresh token" };
        }

        const decoded = decodeBase64Values({
            id: findUser[0].id,
            first_name: findUser[0].first_name,
            last_name: findUser[0].last_name,
            email: findUser[0].email,
        });

        const newRefreshToken = jwtRefreshSign({
            id: decoded.id,
            first_name: decoded.first_name,
            last_name: decoded.last_name,
            email: decoded.email,
        });

        const updateQuery = "UPDATE users SET token = ? WHERE id = ?";
        const [updateResult] = await conn.query(updateQuery, [btoa(encodeURIComponent(newRefreshToken)), decoded.id]);

        // Check if the refresh token was successfully updated
        if (updateResult.affectedRows !== 1) {
            console.error("Failed to save the refresh token. No rows were affected.");
            return { message: "Failed to save the refresh token." };
        }

        return {
            message: "Logout successfully",
        };
    } catch (error) {
        console.error("Error during refreshAuth:", error);
        throw new HttpException(httpStatus.BAD_REQUEST, "Failed to refresh authentication.");
    }
};

const forgotPassword = async (email) => {
    try {
        const conn = await dbConnection;
        let query = "SELECT * FROM users WHERE email = ?";
        const [findUser] = await conn.query(query, [btoa(encodeURIComponent(email))]);

        if (findUser && findUser.length < 1) {
            return { message: "User account does not exist!" };
        }

        const decoded = decodeBase64Values({
            id: findUser[0].id,
            first_name: findUser[0].first_name,
            last_name: findUser[0].last_name,
            email: findUser[0].email,
            google_id: findUser[0].google_id,
            token: findUser[0].token,
        });

        const newResetToken = jwtSecretVerifySign({
            first_name: decoded.first_name,
            last_name: decoded.last_name,
            email: decoded.email,
        });

        const resetPasswordToken = newResetToken;
        const resetLink = process.env.APP_URL + `/reset-password?token=${resetPasswordToken}`;

        await sendVerificationEmail(email, resetLink);

        // Save the resetPasswordToken in your database for future verification
        const hashedResetToken = btoa(encodeURIComponent(newResetToken));
        const updateQuery = "UPDATE users SET reset_token = ? WHERE id = ?";
        await conn.query(updateQuery, [hashedResetToken, decoded.id]);

        return { message: "Email sent successfully. Check your inbox for further instructions." };
    } catch (error) {
        console.error("Error during forgotPassword:", error);
        throw new HttpException(httpStatus.BAD_REQUEST, "Failed to send email.");
    }
};

const resetPassword = async (resetPasswordToken, newPassword) => {
    try {
        // Decode the reset password token to get user information
        const decoded = jwtResetVerifyDecode(resetPasswordToken);

        if (!decoded) {
            return { message: "Invalid reset password token." };
        }

        const conn = await dbConnection;

        // Check if the reset token is blacklisted
        const blacklistedTokenQuery = "SELECT * FROM token_blacklist WHERE token = ?";
        const [blacklistedTokenResult] = await conn.query(blacklistedTokenQuery, [btoa(encodeURIComponent(resetPasswordToken))]);
        console.log(blacklistedTokenResult);
        if (blacklistedTokenResult && blacklistedTokenResult.length > 0) {
            return { message: "Reset token has expired or is invalid." };
        }

        // Check if the user exists
        const decodedEmail = btoa(encodeURIComponent(decoded.email));
        let query = "SELECT * FROM users WHERE email = ?";
        const [findUser] = await conn.query(query, [decodedEmail]);

        if (findUser && findUser.length < 1) {
            return { message: "User account does not exist!" };
        }

        // Update the user's password
        const hashedPassword = await encrypt(newPassword);
        const updateQuery = "UPDATE users SET status=1,password = ? WHERE email = ?";
        await conn.query(updateQuery, [hashedPassword, decodedEmail]);

        // Add the reset token to the token_blacklist table after successful password reset
        const blacklistQuery = "INSERT INTO token_blacklist (token) VALUES (?)";
        await conn.query(blacklistQuery, [btoa(encodeURIComponent(resetPasswordToken))]);

        return { message: "Password reset successfully." };
    } catch (error) {
        console.error("Error during resetPassword:", error);
        throw new HttpException(httpStatus.BAD_REQUEST, "Failed to reset password.");
    }
};

const verifyEmailToken = async (token) => {
    try {
        const conn = await dbConnection;
        const encodedToken = btoa(encodeURIComponent(token));

        // Check if the token is in the blacklist
        const blacklistQuery = "SELECT * FROM token_blacklist WHERE token = ?";
        const [blacklistedToken] = await conn.query(blacklistQuery, [encodedToken]);

        if (blacklistedToken && blacklistedToken.length > 0) {
            // return { message: "Invalid verification token." };
            return { status: "invalid" };
        }

        const query = "SELECT * FROM users WHERE token = ?";
        const [user] = await conn.query(query, [encodedToken]);

        if (user && user.length === 1) {
            // Mark the token as used by adding it to the blacklist
            const blacklistInsertQuery = "INSERT INTO token_blacklist (token) VALUES (?)";
            await conn.query(blacklistInsertQuery, [encodedToken]);

            // Mark the user as verified
            const updateQuery = "UPDATE users SET status = 1 WHERE id = ?";
            await conn.query(updateQuery, [user[0].id]);

            // return { message: "Email verified successfully!" };
            return {
                status: "verified",
                email: decodeURIComponent(atob(user[0].email)),
            };
        } else {
            // return { message: "Invalid verification token." };
            return { status: "invalid" };
        }
    } catch (error) {
        console.error("Error during email verification:", error);
        throw new HttpException(httpStatus.BAD_REQUEST, "Failed to verify email.");
    }
};

module.exports = {
    login,
    refreshAuth,
    logout,
    forgotPassword,
    resetPassword,
    verifyEmailToken,
};
