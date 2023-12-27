const express = require("express");
const { validateSchema } = require("../../middlewares/validate");
const router = express.Router();
const authValidation = require("../../validations/auth.validation");
const authController = require("./auth.controller");
const { authenticateToken } = require("../../middlewares/auth.verify");

router.use("/", (req, res, next) => {
    console.log("/auth");
    next();
});

//AUTH ROUTES
router.post("/register", validateSchema(authValidation.register), authController.register);
router.post("/login", validateSchema(authValidation.login), authController.login);
router.post("/refreshtoken", validateSchema(authValidation.refreshTokens), authController.refreshTokens);
router.post("/forgotpassword", validateSchema(authValidation.forgotPassword), authController.forgotPassword);
router.post("/reset-password", validateSchema(authValidation.resetPassword), authController.resetPassword);
router.post("/logout", authenticateToken, authController.logout);
router.get("/verify-email", authController.verifyEmail);

module.exports = router;
