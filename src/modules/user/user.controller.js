const catchAsync = require("../../utils/catchAsync.js");
const { responseHandler } = require("../../utils/responseHandler.js");
require("dotenv").config();
const userService = require("./user.service.js");

const profile = catchAsync(async (req, res) => {
    const user = "profile";
    return res.send(user);
});
module.exports = { profile };
