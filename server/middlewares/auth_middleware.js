const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
  try {
    const token = req.header("Authorization");
    if (!token) {
      return res.status(401).json({ msg: "No auth token, access denied" });
    }

    const tokenValue = token.replace("Bearer ", "");
    const verified = jwt.verify(tokenValue, process.env.JWT_SECRET);
    console.log("Verification result:", verified);
    if (!verified) {
      return res.status(401).json({ error: "Authorization failed" });
    }

    req.user = verified.id; // Attach user ID to the request
    req.token = token; // Attach token to the request for future use
    next(); // Continue to the next middleware or route handler
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = auth;
