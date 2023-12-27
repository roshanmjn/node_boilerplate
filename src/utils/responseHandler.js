const responseHandler = (response) => ({
    status: 200,
    success: true,
    data: typeof response === "object" ? response : { ...response },
});

module.exports = { responseHandler };
