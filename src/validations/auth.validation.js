const Joi = require("joi");
const { password } = require("./custom.validation");

const register = Joi.object({
    first_name: Joi.string().required(),
    last_name: Joi.string().required(),
    email: Joi.string().required().email(),
    password: Joi.string().required().custom(password),
    confirm_password: Joi.string().valid(Joi.ref("password")).required().custom(password),
});

const login = Joi.object({
    email: Joi.string().required(),
    password: Joi.string().required(),
});

const refreshTokens = Joi.object({
    refreshToken: Joi.string().required(),
});

const mailAccountConfig = Joi.object({
    name: Joi.string().required(),
    email: Joi.string().required().email(),
    imap_host: Joi.string().required(),
    imap_port: Joi.number().integer().default(993),
    imap_security: Joi.string().valid("SSL", "TLS").default("SSL"),
    // imap_username: Joi.string().required(),
    imap_password: Joi.string().required(),
    // smtp_username: Joi.string().required(),
    smtp_password: Joi.string().required(),
    smtp_host: Joi.string().required(),
    smtp_port: Joi.number().integer().default(465),
    smtp_security: Joi.string().valid("SSL", "TLS").default("SSL"),
    description: Joi.string().required(),
});

const forgotPassword = Joi.object({
    email: Joi.string().email().required(),
});

const resetPassword = Joi.object({
    newpassword: Joi.string().required().custom(password),
});

const verifyEmail = Joi.object({
    token: Joi.string().required(),
});

module.exports = {
    register,
    login,
    mailAccountConfig,
    refreshTokens,
    forgotPassword,
    resetPassword,
    verifyEmail,
};
