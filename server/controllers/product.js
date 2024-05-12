const Product = require("../models/product");
const {
  genericErrorResponse,
  genericSuccessResponse,
} = require("../services/genericResponse");

module.exports = {
  createProduct: async (req, res) => {
    if (!req.body.title || !req.body.description || !req.body.price) {
      return genericErrorResponse(
        res,
        "400",
        "Bad request",
        "Title,Description and price are required"
      );
    }
    try {
      const product = new Product(req.body);

      const updatedProduct = await product.save();

      return genericSuccessResponse(res, "Product created successfully");
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  },

  getProducts: async (req, res) => {
    try {
      const updatedProduct = await Product.find();
      return genericSuccessResponse(res, updatedProduct);
    } catch (err) {
      res.status(500).json({ error: "Internal Server Error" });
    }
  },

  deleteProduct: async (req, res) => {
    try {
      const id = req.params.id;
      console.log(id);
      // const product = await Product.findById(id);
      const deletedProduct = await Product.findByIdAndDelete(id);
      if (!deletedProduct) {
        return genericErrorResponse(res, 404, "Product not found");
      }
      return genericSuccessResponse(res, "deletedProduct");
    } catch (err) {
      res.status(500).json({ error: err.message });
      // res.status(500).json({ error: "An error occurred during login" });
    }
  },
  updateProduct: async (req, res) => {
    try {
      const id = req.params.id;
      const updatedProduct = await Product.findOneAndUpdate(
        { _id: id },
        req.body,
        {
          new: true,
        }
      );
      if (!updatedProduct) {
        return genericErrorResponse(res, 404, "Product not found");
      }
      return genericSuccessResponse(res, "Product updated successfully");
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  },
};
