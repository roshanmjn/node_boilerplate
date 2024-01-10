const httpStatus = require("http-status");
const { HttpException } = require("../../middlewares/errors.js");
const { DB } = require("../../database/connection.js");
require("dotenv").config();

const { bcryptDecrypt, bcryptEncrypt, jwtAccessTokenSign, jwtRefreshTokenSign, jwtRefreshTokenDecode } = require("../../utils/encrypter.js");

const register = async (data) => {
    try {
        const { first_name, last_name, email, password, confirm_password, profile_pic = "none" } = data;

        let query = `
            SELECT * FROM users WHERE email = ?`;
        const [findUser] = await DB.query(query, [email]);

        if (findUser && findUser.length > 0) {
            return {
                status: false,
                statusCode: httpStatus.BAD_REQUEST,
                message: "User with email already exists !",
            };
        }
        if (password !== confirm_password) {
            return {
                status: false,
                statusCode: httpStatus.BAD_REQUEST,
                message: "Passwords do not match !",
            };
        }

        query = `
            INSERT INTO users
                (first_name,last_name,email,password,profile_pic)
            VALUES(?,?,?,?,?)`;
        const hashedPassword = await bcryptEncrypt(password);
        const [user] = await DB.query(query, [first_name, last_name, email, hashedPassword, profile_pic]);

        if (user.affectedRows === 0) {
            return {
                status: false,
                statusCode: httpStatus.BAD_REQUEST,
                message: "Failed to create user !",
            };
        }

        return {
            status: true,
            statusCode: httpStatus.OK,
            message: "User created successfully !",
        };
    } catch (error) {
        console.log("Error while creating user: " + error);
        throw new HttpException(httpStatus.INTERNAL_SERVER_ERROR, "Error while creating user.");
    }
};
const login = async (email, password, deviceId) => {
    try {
        const query = `SELECT id,email,password,profile_pic FROM users WHERE email = ?;`;
        const [findUser] = await DB.query(query, [email]);
        console.log(findUser);
        if (!findUser || findUser.length < 1) {
            return { message: "User account does not exist!" };
        }

        const decodedPassword = await bcryptDecrypt(password, findUser[0].password);
        if (!decodedPassword) {
            return new HttpException(httpStatus.BAD_REQUEST, "Invalid password!");
        }
        const jwtConfig = {
            id: findUser[0].id,
            first_name: findUser[0].first_name,
            last_name: findUser[0].last_name,
            email: findUser[0].email,
            device_id: deviceId,
        };
        const accessToken = jwtAccessTokenSign(jwtConfig);
        const refreshToken = jwtRefreshTokenSign(jwtConfig);

        const checkPreviousSession = `SELECT * FROM user_sessions WHERE user_id = ? AND device_id = ?;`;
        const [previousSession] = await DB.query(checkPreviousSession, [findUser[0].id, deviceId]);
        if (previousSession && previousSession.length > 0) {
            const updateSessionQuery = `
                UPDATE user_sessions SET refresh_token = ?, updated_at = NOW() 
                WHERE user_id = ? AND device_id = ?;`;
            const [updateResult] = await DB.query(updateSessionQuery, [refreshToken, findUser[0].id, deviceId]);
            if (updateResult.affectedRows !== 1) {
                console.error("Failed to save the refresh token. No rows were affected.");
                return new HttpException(httpStatus.BAD_REQUEST, "Failed to save the refresh token.");
            }
        } else {
            const insertSession = `INSERT INTO user_sessions (user_id,device_id,refresh_token) VALUES (?,?,?);`;
            const [insertResult] = await DB.query(insertSession, [findUser[0].id, deviceId, refreshToken]);
            if (insertResult.affectedRows !== 1) {
                console.error("Failed to save the refresh token. No rows were affected.");
                return new HttpException(httpStatus.BAD_REQUEST, "Failed to save the refresh token.");
            }
        }
        return {
            id: findUser[0].id,
            email: findUser[0].email,
            profile_pic: findUser[0].profile_pic,
            access_token: accessToken,
            refresh_token: refreshToken,
            device_id: deviceId,
        };
    } catch (error) {
        console.error("Error during login:", error);
        throw new HttpException(error.statusCode, error.errors);
    }
};

const refreshAccessToken = async (refreshToken, deviceId) => {
    try {
        if (!refreshToken) {
            console.log("Refresh token not found, Please Login Again.");
            return new HttpException(httpStatus.UNAUTHORIZED, "Please Login Again.");
        }

        const decodedRefreshToken = jwtRefreshTokenDecode(refreshToken);
        const userId = decodedRefreshToken.id ?? null;

        let query = `
            SELECT 
                u.id,u.first_name ,u.last_name ,u.email,u.profile_pic ,
                us.device_id ,us.refresh_token 
            from users u
            left join user_sessions us 
            on us.user_id =u.id 
            WHERE refresh_token = ? AND device_id = ? AND user_id = ?;`;
        const [findUser] = await DB.query(query, [refreshToken, deviceId, userId]);

        if (findUser.length === 0) {
            console.log("Invalid Refresh token, login again to continue.");
            return new HttpException(httpStatus.BAD_REQUEST, "UNAUTHORIZED");
        }
        const jwtConfig = {
            id: findUser[0].id,
            first_name: findUser[0].first_name,
            last_name: findUser[0].last_name,
            email: findUser[0].email,
            device_id: deviceId,
        };

        const newRefreshToken = jwtRefreshTokenSign(jwtConfig);
        const newAccessToken = jwtAccessTokenSign(jwtConfig);

        const updateQuery = `
            UPDATE user_sessions 
            SET refresh_token = ? 
            WHERE user_id = ? AND device_id = ?;`;
        const [updateResult] = await DB.query(updateQuery, [newRefreshToken, userId, deviceId]);

        if (updateResult.affectedRows === 0) {
            console.error("Failed to save the refresh token. No rows were affected.");
            return new HttpException(httpStatus.BAD_REQUEST, "Failed to save the refresh token.");
        }

        return {
            id: findUser[0].id,
            email: findUser[0].email,
            profile_pic: findUser[0].profile_pic,
            access_token: newAccessToken,
            refresh_token: newRefreshToken,
        };
    } catch (error) {
        console.error("Error during refreshAuth:", error);
        throw new HttpException(httpStatus.INTERNAL_SERVER_ERROR, error);
    }
};

const logout = async (refreshToken, deviceId) => {
    try {
        if (!refreshToken) {
            console.log("Refresh token not found,Please Login Again.");
            return new HttpException(httpStatus.UNAUTHORIZED, "Please Login Again.");
        }

        const decodedRefreshToken = jwtRefreshTokenDecode(refreshToken);
        const userId = decodedRefreshToken.id ?? null;

        let query = `
            SELECT user_id,device_id,refresh_token 
            FROM user_sessions 
            WHERE refresh_token = ? AND device_id = ? AND user_id = ?;`;
        const [findUser] = await DB.query(query, [refreshToken, deviceId, userId]);

        if (findUser.length === 0) {
            console.log("Invalid Refresh token, login again to continue.");
            return new HttpException(httpStatus.UNAUTHORIZED, "Please Re-Authticate.");
        }

        const newRefreshToken = jwtRefreshTokenSign({
            id: findUser[0].user_id,
            device_id: findUser[0].device_id,
        });

        const updateQuery = `
            UPDATE user_sessions 
            SET refresh_token = ? 
            WHERE user_id = ? AND device_id = ?;`;
        const [updateResult] = await DB.query(updateQuery, [newRefreshToken, userId, deviceId]);

        if (updateResult.affectedRows === 0) {
            console.error("Failed to save the refresh token. Error logging out.");
            return new HttpException(httpStatus.BAD_REQUEST, "Error logging out.");
        }

        return [];
    } catch (error) {
        console.error("Error during refreshAuth:", error);
        throw new HttpException(httpStatus.INTERNAL_SERVER_ERROR, error);
    }
};

module.exports = {
    register,
    login,
    refreshAccessToken,
    logout,
};
