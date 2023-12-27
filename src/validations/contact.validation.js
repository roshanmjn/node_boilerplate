const joi = require("joi");

const contactSchema = joi.object({
    name: joi.string().required(),
});

module.exports = {
    contactSchema
}