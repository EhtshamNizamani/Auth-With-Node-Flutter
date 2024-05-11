const User = require("../models/user");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

module.exports = {
  signUp: async (req, res) => {
    try {
      const { name = "", email = "", password = "" } = req.body;

      const existingUser = await User.findOne({ email });
      if (existingUser) {
        res.status(400).json({ msg: "This email is already register " });
        return;
      }
      const hashPassword = await bcrypt.hash(password, 8);
      let user = new User({
        name,
        email,
        password: hashPassword,
      });
      user = await user.save();

      res.json({ user });
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  },

  login: async (req, res) => {
    try {
      const { email = "", password = "" } = req.body;
      const existingUser = await User.findOne({ email });
      if (!existingUser) {
        res.status(401).json({ error: "invalid credentials" });
        return;
      }

      const isValidPassword = await bcrypt.compare(
        password,
        existingUser.password
      );
      if (!isValidPassword) {
        console.log("invalid credentials");

        res.status(401).json({ error: "Invalid Password" });

        return;
      }
      console.log(process.env.JWT_SECRET);
      const token = jwt.sign(
        {
          userId: existingUser._id,
          email: existingUser.email,
        },
        process.env.JWT_SECRET,
        { expiresIn: "7d" }
      );
      res.json({
        message: "Login successful",
        token,
        ...existingUser._doc,
      });
    } catch (err) {
      console.log("Login error:", err);
      res.status(500).json({ error: "An error occurred during login" });
    }
  },

  getUserData: async (req, res) => {
    console.log(req.headers);

    const user = await User.findOne(req.user);
    if (user) {
      console.log(user.token);
      res.status(201).json({ ...user._doc, token: user.token });
    }
  },
};
