const mongoose = require("mongoose");

const userProfileSchema = mongoose.Schema({
  userName: { required: true, type: String, trim: true },
  profileImageUrl: { type: String },
});

const UserProfile = mongoose.model("UserProfile", userProfileSchema);

module.exports = UserProfile;
