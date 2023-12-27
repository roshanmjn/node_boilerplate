const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const { HttpException } = require("../middlewares/errors");

const decodeBase64Values = (obj) => {
    for (const key in obj) {
        if (typeof obj[key] === "string") {
            try {
                obj[key] = decodeURIComponent(atob(obj[key]));
            } catch (error) {
                console.error("Decoding error:", error.message);
            }
        }
    }
    return obj;
};

const bcryptEncrypt = async (data) => {
    try {
        const hash = await bcrypt.hash(data.toString(), 10);
        return hash;
    } catch (error) {
        throw new Error("Encryption failed: " + error.message);
    }
};

const bcryptDecrypt = async (data, hash) => {
    try {
        const result = await bcrypt.compare(data.toString(), hash);
        return result;
    } catch (error) {
        throw new Error("Decryption failed: " + error.message);
    }
};

const jwtSign = (payload, secret, expiresIn) => {
    try {
        return jwt.sign(payload, secret, { expiresIn: expiresIn });
    } catch (error) {
        console.error("Error signing JWT:", error.message);
        throw new Error("Failed to sign JWT");
    }
};
const jwtDecode = (token, secret) => {
    try {
        return jwt.verify(token, secret);
    } catch (error) {
        console.error("Error decoding JWT:", error.message);
        throw new HttpException(401, "Failed to decode JWT");
    }
};
const jwtAccessTokenSign = (data, expiresIn = "7d") => {
    try {
        const options = { expiresIn };
        return jwt.sign(data, process.env.JWT_SECRET_REFRESH, options);
    } catch (error) {
        console.error("Error signing refresh JWT:", error.message);
        throw new Error("Failed to sign refresh JWT");
    }
};

const jwtAccessTokenDecode = (token) => {
    try {
        return jwt.verify(token, process.env.JWT_SECRET_REFRESH);
    } catch (error) {
        console.error("Error decoding refresh JWT:", error.message);
        throw new Error("Failed to decode refresh JWT");
    }
};
const jwtRefreshTokenSign = (data, expiresIn = "7d") => {
    try {
        const options = { expiresIn };
        return jwt.sign(data, process.env.JWT_SECRET_REFRESH, options);
    } catch (error) {
        console.error("Error signing refresh JWT:", error.message);
        throw new Error("Failed to sign refresh JWT");
    }
};

const jwtRefreshTokenDecode = (token) => {
    try {
        return jwt.verify(token, process.env.JWT_SECRET_REFRESH);
    } catch (error) {
        console.error("Error decoding refresh JWT:", error.message);
        throw new Error("Failed to decode refresh JWT");
    }
};

const hasTokenExpired = (expiryDate) => {
    const currentTimestamp = Date.now();
    return currentTimestamp >= Number(expiryDate);
};
module.exports = {
    decodeBase64Values,
    bcryptEncrypt,
    bcryptDecrypt,
    jwtSign,
    jwtDecode,
    jwtAccessTokenSign,
    jwtAccessTokenDecode,
    jwtRefreshTokenSign,
    jwtRefreshTokenDecode,
    hasTokenExpired,
};
