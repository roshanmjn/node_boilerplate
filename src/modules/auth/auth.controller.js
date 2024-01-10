const httpStatus = require("http-status");
const catchAsync = require("../../utils/catchAsync.js");
const { authService } = require("../../services/index.js");
const { responseHandler } = require("../../utils/responseHandler.js");

const register = catchAsync(async (req, res) => {
    const user = await authService.register(req.body);
    return res.status(httpStatus.CREATED).send(user);
});

const login = catchAsync(async (req, res) => {
    const { email, password, device_id } = req.body;
    const user = await authService.login(email, password, device_id);
    res.cookie("access_token", user?.access_token, {
        httpOnly: true,
        maxAge: 12 * 60 * 60 * 1000, // 12 hours
    });
    res.cookie("refresh_token", user?.refresh_token, {
        httpOnly: true,
        maxAge: 7 * 24 * 60 * 60 * 1000, // 7 days
    });
    return res.json(responseHandler(user));
});

const logout = catchAsync(async (req, res) => {
    const refreshToken = req.cookies.refresh_token;
    const deviceId = req.headers.device_id;
    const result = await authService.logout(refreshToken, deviceId);
    return res.status(result.statusCode ?? httpStatus.OK).send(result);
});

const refreshTokens = catchAsync(async (req, res) => {
    console.log(req.cookies);
    const refreshToken = req.cookies.refresh_token;
    const deviceId = req.headers.device_id;
    const tokens = await authService.refreshAccessToken(refreshToken, deviceId);
    res.cookie("access_token", tokens?.access_token, {
        httpOnly: true,
        maxAge: 12 * 60 * 60 * 1000, // 12 hours
    });
    res.cookie("refresh_token", tokens?.refresh_token, {
        httpOnly: true,
        maxAge: 7 * 24 * 60 * 60 * 1000, // 7 days
    });
    return res.status(tokens.statusCode ?? httpStatus.OK).send(tokens);
});

module.exports = {
    register,
    login,
    refreshTokens,
    logout,
};
