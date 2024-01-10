/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
    return knex.schema.hasTable("users").then((exists) => {
        if (!exists) {
            return knex.schema.createTable("users", (table) => {
                table.increments("id");
                table.string("first_name", 255);
                table.string("last_name", 255);
                table.string("email", 255);
                table.string("password", 255);
                table.boolean("active").defaultTo(true);
                table.dateTime("created_at").defaultTo(knex.fn.now());
                table.dateTime("updated_at").defaultTo(knex.fn.now());
            });
        }
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
    return knex.schema.dropTable("users");
};
