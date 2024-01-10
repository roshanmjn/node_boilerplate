const express = require("express");
const router = express.Router();
const { userController } = require("../../controllers/index");
router.use("/", (req, res, next) => {
    console.log("/user");
    next();
});

module.exports = router;
