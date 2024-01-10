require("dotenv").config();
module.exports = {
    development: {
        username: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME,
        host: process.env.DB_HOST,
        dialect: process.env.DB_DIALECT,
        seederStorage: "json",
        seederStoragePath: "sequelizeData.json",
        seederStorageTableName: "seeder_data",
    },
    production: {
        username: process.env.PROD_DB_USER,
        password: process.env.PROD_DB_PASSWORD,
        database: process.env.PROD_DB_NAME,
        host: process.env.PROD_DB_HOST,
        dialect: process.env.PROD_DB_DIALECT,
        seederStorage: "json",
        seederStoragePath: "sequelizeData.json",
        seederStorageTableName: "seeder_data",
    },
};
