require("dotenv").config({
    path: "../../.env",
});
const path = require("path");
const fs = require("fs");
console.log(process.env.NODE_ENV);
const config = {
    client: "mysql2",
    connection: {
        host: process.env.NODE_ENV === "production" ? process.env.PROD_DB_HOST : process.env.DB_HOST,
        port: process.env.NODE_ENV === "production" ? process.env.PROD_DB_PORT : process.env.DB_PORT,
        user: process.env.NODE_ENV === "production" ? process.env.PROD_DB_USER : process.env.DB_USER,
        password: process.env.NODE_ENV === "production" ? process.env.PROD_DB_PASSWORD : process.env.DB_PASSWORD,
        database: process.env.NODE_ENV === "production" ? process.env.PROD_DB_NAME : process.env.DB_NAME,
    },
    pool: {
        min: 2,
        max: 10,
    },
    migrations: {
        tableName: "migrations",
        directory: path.resolve(__dirname, "migrations"),
    },
    seeds: {
        directory: path.resolve(__dirname, "seeds"),
    },
    // debug: process.env.NODE_ENV === "development",
};
function createDirectoryIfNotExist(directory) {
    if (!fs.existsSync(directory)) {
        fs.mkdirSync(directory, { recursive: true });
        console.log(`Directory created: ${directory}`);
    } else {
        // console.log(`Directory already exists: ${directory}`);
    }
}
function initializeServer() {
    createDirectoryIfNotExist(config.migrations.directory);
    createDirectoryIfNotExist(config.seeds.directory);
}
initializeServer();

module.exports = config;
