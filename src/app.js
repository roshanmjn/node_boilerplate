const express = require("express");
const app = express();
require("dotenv").config();
const cors = require("cors");
const cookieParser = require("cookie-parser");
const errorHandler = require("./middlewares/errorHandler.js");
const { NotFound } = require("./middlewares/errors");
const v1 = require("./routes");
const port = process.env.PORT || 3000;
app.use(
    cors({
        origin: "*",
    })
);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());
app.use("/api/v1", v1);

app.all("*", () => {
    throw new NotFound("Page not found!");
});
app.use(errorHandler);
app.listen(port, () => {
    console.log(`listening to http://localhost:${port}`);
});
