const express = require("express");
const app = express();
require("dotenv").config();
const cors = require("cors");
const errorHandler = require("./middlewares/errorHandlers");
const { NotFound, HttpException } = require("./middlewares/errors");
const v1 = require("./routes");

app.use(
    cors({
        origin: "*",
    })
);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
const port = process.env.PORT || 3000;

app.use("/api/v1", v1);

app.all("*", () => {
    throw new NotFound("Page not found!");
});
app.use(errorHandler);
app.listen(port, () => {
    try {
        console.log(`listening to http://localhost:${port}`);
    } catch (err) {
        throw HttpException(500, "Internal server error");
    }
});
