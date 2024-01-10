const objectId = (value, helpers) => {
    if (!value.match(/^[0-9a-fA-F]{24}$/)) {
        return helpers.message('"{{#label}}" must be a valid id column');
    }
    return value;
};

const password = (value, helpers) => {
    if (value.length < 8) {
        return helpers.message("password must be at least 8 characters");
    }
    if (!value.match(/\d/)) {
        return helpers.message("password must contain at least 1 number ");
    }
    if (!value.match(/[a-zA-Z]/)) {
        return helpers.message("password must contain at least 1 letter");
    }

    return value;
};
const confirm_pass = (value, helpers) => {
    if (value !== helpers.state.ancestors[0].password) {
        return helpers.message("Passwords do not match");
    }
    return value;
};

module.exports = {
    objectId,
    password,
    confirm_pass,
};
