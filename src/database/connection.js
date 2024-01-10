const mysql2 = require("mysql2/promise");
const Knex = require("knex")(require("./knexfile"));
require("dotenv").config();

console.log(process.env.NODE_ENV);

let config = {
    host: process.env.NODE_ENV === "production" ? process.env.PROD_DB_HOST : process.env.DB_HOST,
    user: process.env.NODE_ENV === "production" ? process.env.PROD_DB_USER : process.env.DB_USER,
    password: process.env.NODE_ENV === "production" ? process.env.PROD_DB_PASSWORD : process.env.DB_PASSWORD,
    database: process.env.NODE_ENV === "production" ? process.env.PROD_DB_NAME : process.env.DB_NAME,
};

const DB = mysql2.createPool({
    host: config.host,
    user: config.user,
    password: config.password,
    database: config.database,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
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

setInterval(() => {
    pingDB();
}, 40000);

module.exports = { DB, Knex };
