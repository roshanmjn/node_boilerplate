const jwt = require("jsonwebtoken");
const { HttpException } = require("./errors");

function authenticateToken(req, res, next) {
    const token = req.cookies["access_token"] || req.headers["x-access-token"];

    if (!token) {
        throw new HttpException(401, "Authentication failed: Token missing");
    }

    jwt.verify(token, process.env.JWT_ACCESS_SECRET, (err, decoded) => {
        if (err) {
            if (err.name === "JsonWebTokenError") {
                throw new HttpException(401, "Authentication failed: Invalid token");
            } else if (err.name === "TokenExpiredError") {
                throw new HttpException(401, "Authentication failed: Token expired");
            } else {
                throw new HttpException(500, "Internal server error");
            }
        }
        next();
    });
}

module.exports = { authenticateToken };
