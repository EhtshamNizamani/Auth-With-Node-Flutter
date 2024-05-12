const express = require("express");
const auth = require("../../middlewares/auth_middleware");
const productController = require("../../controllers/product");

const authRouter = express.Router();

authRouter.post("/product", auth, productController.createProduct);
authRouter.get("/product", auth, productController.getProducts);
authRouter.delete("/product/:id", auth, productController.deleteProduct);
authRouter.patch("/product/:id", auth, productController.updateProduct);

module.exports = authRouter;
