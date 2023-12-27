const httpStatus = require("http-status");
const catchAsync = require("../../utils/catchAsync.js");
const { authService, userService } = require("../../services/index.js");
const { responseHandler } = require("../../utils/responseHandler.js");

const register = catchAsync(async (req, res) => {
    const user = await userService.createUser(req.body);
    return res.status(httpStatus.CREATED).send({ user });
});

const login = catchAsync(async (req, res) => {
    const { email, password } = req.body;
    const user = await authService.login(email, password);
    res.cookie("access_token", user?.token, {
        httpOnly: true,
        maxAge: 12 * 60 * 60 * 1000, // 12 hours
    });
    res.cookie("refresh_token", user?.refreshToken, {
        httpOnly: true,
        maxAge: 7 * 24 * 60 * 60 * 1000, // 7 days
    });
    return res.json(responseHandler(user));
});

const logout = catchAsync(async (req, res) => {
    const refreshToken = req.body.refreshToken;
    const user = await authService.logout(refreshToken);
    if (user.message == "Logout successfully") {
        res.clearCookie("access_token");
        return res.status(httpStatus.OK).send("Logout successfully");
    } else {
        return res.status(httpStatus.BAD_REQUEST).send({ user });
    }
});

const refreshTokens = catchAsync(async (req, res) => {
    const tokens = await authService.refreshAuth(req.body.refreshToken);
    res.send({ ...tokens });
});

const forgotPassword = catchAsync(async (req, res) => {
    const { email } = req.body;
    const user = await authService.forgotPassword(email);
    res.send(user);
});

const resetPassword = catchAsync(async (req, res) => {
    const { newpassword, token } = req.body;
    console.log(newpassword);
    const user = await authService.resetPassword(token, newpassword);
    return res.send(user);
});

const verifyEmail = catchAsync(async (req, res) => {
    const { token } = req.query;
    console.log(token);
    const user = await authService.verifyEmailToken(token);
    console.log(user);
    return res.redirect(process.env.APP_URL + `?status=${user.status}&email=${user.email}`);
});

module.exports = {
    register,
    verifyEmail,
    login,
    logout,
    forgotPassword,
    resetPassword,

    refreshTokens,
};
