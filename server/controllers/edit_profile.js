const User = require("../models/user");
const UserProfile = require("../models/user_profile");
const genericSuccessResponse = require("../services/genericResponse");

const editUserProfile = async (req, res) => {
  try {
    const id = req.params.id;
    console.log(id);
    const userJSON = {};
    userJSON["userName"] = req.body.userName;
    const imageUrl = `http://localhost:3500/uploads/${req.file.filename}`; // Example URL
    userJSON["image"] = imageUrl;
    const existingUser = await User.findById(id);
    if (!existingUser) {
      res.status(201).json({ msg: "User not found" });
    }

    // Update the user profile
    existingUser.userName = userJSON.userName;
    existingUser.image = userJSON.image;

    const newUser = new UserProfile({
      userName: userJSON.userName,
      profileImageUrl: userJSON.image,
    });
    const updatedUser = await newUser.save();

    await existingUser.save();

    return genericSuccessResponse.genericSuccessResponse(res, updatedUser);
  } catch (err) {
    console.error("Error saving user:", err);

    res.status(500).json({ error: err.message });
  }
};

module.exports = { editUserProfile };
