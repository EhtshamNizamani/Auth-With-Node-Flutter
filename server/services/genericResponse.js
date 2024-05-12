exports.genericSuccessResponse = function (res, data) {
  return res.status(200).json({
    success: true,
    error: "",
    data: data,
  });
};

exports.genericErrorResponse = function (
  res,
  statusCode,
  error,
  message = null
) {
  return res.status(statusCode).json({
    success: false,
    error: error,
    data:
      message == null
        ? {}
        : {
            message: message,
          },
  });
};
