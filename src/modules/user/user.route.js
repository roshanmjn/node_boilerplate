const express = require("express");
const router = express.Router();
const { userController } = require("../../controllers/index");
const weather = require("weather-js");
router.use("/", (req, res, next) => {
    console.log("/user");
    next();
});

router.get("/profile", userController.profile);

router.post("/weather", (req, res) => {
    let city = req.body.city;

    // get more forecast data
    weather.find({ search: city, degreeType: "F" }, function (err, result) {
        if (err) console.log(err);

        res.send(result);
    });
});

module.exports = router;
