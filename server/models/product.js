const mongoose = require("mongoose");
const Schema = mongoose.Schema;

// Define schema for products collection
const productSchema = new Schema({
  title: { type: String, required: true },
  description: { type: String, required: true },
  price: { type: Number, required: true },
  rating: { type: Number, required: true },
  brand: { type: String, required: true },
  images: { type: String, required: true },
});

// Create a model based on the schema
const Product = mongoose.model("Product", productSchema);

module.exports = Product;
