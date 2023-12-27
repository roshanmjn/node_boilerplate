const { Sequelize } = require("sequelize");
const mysql2 = require("mysql2/promise");
require("dotenv").config();
let config;

console.log(process.env.NODE_ENV);

if (process.env.NODE_ENV === "production") {
    config = {
        host: process.env.PROD_DB_HOST,
        user: process.env.PROD_DB_USER,
        password: process.env.PROD_DB_PASSWORD,
        database: process.env.PROD_DB_NAME,
    };
} else {
    config = {
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME,
    };
}

const DB = mysql2.createPool({
    host: config.host,
    user: config.user,
    password: config.password,
    database: config.database,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
});

const sequelize = new Sequelize(config.database, config.user, config.password, {
    host: config.host,
    dialect: "mysql",
    logging: false,
    define: {
        freezeTableName: true,
        underscored: true,
        timestamps: true,
        createdAt: "created_at",
        updatedAt: "updated_at",
    },
});

async function pingDB() {
    try {
        const [rows] = await DB.query("SELECT 1 + 1 AS solution");
        console.log("The solution is: ", rows[0].solution);
    } catch (error) {
        throw error;
    }
}

pingDB();

setTimeout(() => {
    pingDB();
}, 40000);

module.exports = { DB, sequelize };
