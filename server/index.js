const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/user_management/auth");
const productRouter = require("./routes/product_management/product");
const config = require("dotenv");
const PORT = 3500;
const DB =
  "mongodb+srv://ehtshamnizamani89:ehtsham123@cluster0.kucshfn.mongodb.net/";
const app = express();
app.use(express.json());
app.use(`/api`, authRouter);
app.use(`/api`, productRouter);

config.config();
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});
