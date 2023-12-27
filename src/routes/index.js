const express = require("express");
const router = express.Router();
const authRoute = require("../modules/auth/auth.route.js");

router.use("/", (req, res, next) => {
    console.log("/api/v1");
    next();
});

router.use("/auth", authRoute);

module.exports = router;
