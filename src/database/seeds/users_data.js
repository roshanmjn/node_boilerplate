/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.seed = async function (knex) {
    await knex("users").del();
    await knex("users").insert([
        { id: 1, first_name: "Test", last_name: "TestUser", email: "test@gmail.com", password: "$2a$10$rsiZXKWz8/s6DbP743DcFuo1kfQV.17TwSwSUNT9dn0vu1/cTR06m" },
    ]); //pwd:password123
};
