const express = require("express");
const { validateSchema } = require("../../middlewares/validate");
const router = express.Router();
const { login, refreshTokens, register } = require("../../validations/auth.validation");
const authController = require("./auth.controller");
const { authenticateToken } = require("../../middlewares/auth.verify");

router.use("/", (req, res, next) => {
    console.log("/auth");
    next();
});

//AUTH ROUTES
router.post("/register", validateSchema(register), authController.register);
router.post("/login", validateSchema(login), authController.login);
router.post("/refresh", authController.refreshTokens);
router.get("/logout", authenticateToken, authController.logout);

module.exports = router;
