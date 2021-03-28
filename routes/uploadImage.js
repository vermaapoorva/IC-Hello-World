const upload = require("./upload");
const singleUpload = upload.single("image");
const express = require("express");
const router = express.Router();

router.post("/", (req, res) => {

  singleUpload(req, res, function (err) {
    if (err) {
      return res.json({
        success: false,
        errors: {
          title: "Image Upload Error",
          detail: err.message,
          error: err,
        },
      });
    }

    let update = { profilePicture: req.file.location };

    // User.findByIdAndUpdate(uid, update, { new: true })
    //   .then((user) => res.status(200).json({ success: true, user: user }))
    //   .catch((err) => res.status(400).json({ success: false, error: err }));
  });

  res.send("done")

});

module.exports = router;