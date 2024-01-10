class HttpException extends Error {
    constructor(statusCode, message) {
        super(message);
        this.status = "error";
        this.statusCode = statusCode;
        this.errors = message;
    }
}

class NotFound extends HttpException {
    constructor(message = "Not Found!") {
        super(404, message);
    }
}
class NotAuthorized extends HttpException {
    constructor() {
        super(401, "Unauthorized access!");
    }
}
const parseValidationError = (req, res, err) => {
    const errors = [];

    err.details?.forEach((error) => {
        errors.push({
            path: error.path[0],
            label: error.context.label,
            message: error.message,
        });
    });

    return res.status(422).json({ status: "error", statusCode: 422, errors: errors });
};

module.exports = {
    HttpException,
    NotFound,
    NotAuthorized,
    parseValidationError,
};
