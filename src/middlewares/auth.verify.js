const jwt = require("jsonwebtoken");

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

module.exports = { authenticateToken };
