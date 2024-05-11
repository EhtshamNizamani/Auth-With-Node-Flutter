const multer = require("multer");

// Set up multer for file uploads
const storage = multer.diskStorage({
  destination: "/uploads",

  filename: function (req, file, cb) {
    console.log(`${Date.now()}-${file.originalname}`);
    const fileName = `${Date.now()}-${file.originalname}`;
    cb(null, fileName);
  },
});

const upload = multer({ storage: storage });

module.exports = upload;
