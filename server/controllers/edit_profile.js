const User = require("../models/user");
const UserProfile = require("../models/user_profile");

const editUserProfile = async (req, res) => {
  try {
    const id = req.params.id;

    const userName = req.body.userName;

    const imageUrl = `http://localhost:3500/uploads/${req.file.filename}`; // Example URL

    // await User.findById(id);
    const existingUser = await User.findById(id);
    if (!existingUser) {
      res.status(201).json({ msg: "User not found" });
    }
    const newUser = new UserProfile({
      userName: userName,
      profileImageUrl: imageUrl,
    });

    savedUser = await newUser.save();

    res.status(201).json(savedUser);
  } catch (err) {
    console.error("Error saving user:", err);

    res.status(500).json({ error: err.message });
  }
};

module.exports = { editUserProfile };
