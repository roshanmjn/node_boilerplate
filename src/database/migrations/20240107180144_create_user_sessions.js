/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */

exports.up = async function (knex) {
    try {
        await knex.schema.dropTableIfExists("user_sessions");
        await knex.schema.createTable("user_sessions", async (table) => {
            table.increments("id");
            table.integer("user_id").unsigned().notNullable();
            table.foreign("user_id").references("id").inTable("users").onDelete("CASCADE").onUpdate("CASCADE");
            table.string("device_id");
            table.text("refresh_token").notNullable();
            table.dateTime("created_at").defaultTo(knex.fn.now());
            table.dateTime("updated_at").defaultTo(knex.fn.now());
        });
    } catch (error) {
        console.error(
            "\x1b[41m\x1b[37mError creating table user_sessions:\x1b[0m\x1b[0m\x1b[31m\n",
            error.sqlMessage,
            "\nPlease rollback migration.",
            "\x1b[0m"
        );
    }
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
    return knex.schema.dropTable("user_sessions");
};
