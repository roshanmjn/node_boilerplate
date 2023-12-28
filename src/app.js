const express = require("express");
const app = express();
require("dotenv").config();
const cors = require("cors");
const errorHandler = require("./middlewares/errorHandler.js");
const { NotFound, HttpException } = require("./middlewares/errors");
const v1 = require("./routes");
const port = process.env.PORT || 3000;
app.use(
    cors({
        origin: "*",
    })
);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const crypto = require("crypto");
const { scrypt, randomFill, createCipheriv, scryptSync, createDecipheriv } = require("crypto");
const { createReadStream, createWriteStream } = require("fs");
const { Buffer } = require("node:buffer");
app.get("/test", async (req, res) => {
    try {
        const algorithm = "aes-192-cbc";
        const password = "Password used to generate key";
        const key = crypto.scryptSync(password, "salt", 24);
        // generate 16 bytes of random data
        const initVector = crypto.randomBytes(16);

        const message = { test: 99999, ranbga: "asdaishdoinikn)(U)!@(*)()HOI!@(*#^Y!@)#", u1029: 81823761278 };

        // the cipher function
        const cipher = crypto.createCipheriv(algorithm, key, initVector);
        let encryptedData = cipher.update(JSON.stringify(message), "utf-8", "hex");

        encryptedData += cipher.final("hex");

        return res.send({ encryptedData, initVector, password });
    } catch (err) {
        console.error("crypto support is disabled!:", err);
    }
});
app.get("/test2", async (req, res) => {
    try {
        const algorithm = "aes-192-cbc";
        const password = "Password used to generate key";
        const key = crypto.scryptSync(password, "salt", 24);

        // Retrieve the encrypted data and the initialization vector from the request body
        const encryptedData =
            "36ed79f99d3349c5b3f1736204f039b0a7fcc2a6f6fc0da259258f93aae9591cdc51b61486842780a45d7653e8362d4b2a851e5124403c7f0c9f1c6fa65b7ba25ba076a8a5ba0523205fb9a251d1724e2df42fb0048d4114597bb19c6f95e4a6";
        const initVector = {
            type: "Buffer",
            data: [53, 135, 181, 29, 229, 60, 147, 127, 53, 65, 174, 91, 84, 142, 2, 68],
        };

        // Convert the initialization vector and encrypted data to Buffer objects
        const iv = Buffer.from(initVector, "hex");
        const encryptedDataBuffer = Buffer.from(encryptedData, "hex");

        // Create a decipher using the same algorithm, key, and IV
        const decipher = crypto.createDecipheriv(algorithm, key, iv);

        // Decrypt the data
        let decrypted = decipher.update(encryptedDataBuffer, "binary", "utf8");
        decrypted += decipher.final("utf8");

        // Parse the decrypted data (assuming it was originally JSON)
        const decryptedJSON = JSON.parse(decrypted);

        return res.send({ decryptedData: decryptedJSON });
    } catch (err) {
        console.error("Decryption failed:", err);
        return res.status(500).send("Decryption failed");
    }
});
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
