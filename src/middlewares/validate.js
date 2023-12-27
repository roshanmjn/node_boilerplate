const { parseValidationError } = require("../middlewares/errors.js");
const validateSchema = (schema) => async (req, res, next) => {
    try {
        const { error, value } = schema.validate(req.body, {
            stripUnknown: true,
            abortEarly: false,
        });
        if (error) {
            throw error;
        }
        next();
    } catch (err) {
        parseValidationError(req, res, err);
    }
};

module.exports = { validateSchema };
