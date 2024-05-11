exports.genericSuccessResponse = function (res, data) {
  return res.status(200).json({
    success: true,
    error: "",
    data: data,
  });
};
