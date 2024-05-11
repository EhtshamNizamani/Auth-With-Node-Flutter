const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  userName: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^([a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+)@([a-zA-Z0-9-]+)(\.[a-zA-Z]{2,})$/;

        return value.match(re);
      },
    },
    message: "Email is not validate",
  },
  password: {
    required: true,
    type: String,
    trim: true,
  },
});
const User = mongoose.model("User", userSchema);
module.exports = User;
