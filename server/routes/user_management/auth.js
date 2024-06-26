const express = require("express");

const auth = require("../../middlewares/auth_middleware");
const authRouter = express.Router();
const storage = require("../../middlewares/storage_middleware");
const editProfileController = require("../../controllers/edit_profile");
const authController = require("../../controllers/auth");

authRouter.patch(
  "/upload/:id",
  auth,
  storage.single("image"),
  editProfileController.editUserProfile
);

authRouter.post("/signup", authController.signUp);

authRouter.post("/login", authController.login);

authRouter.get("/", auth, authController.getUserData);

module.exports = authRouter;
