const aws = require("aws-sdk");
const multer = require("multer");
const multerS3 = require("multer-s3");
const s3 = new aws.S3();

const config = require("config");

aws.config.update({
    secretAccessKey: config.get("S3_ACCESS_SECRET"),
    accessKeyId: config.get("S3_ACCESS_KEY"),
    region: "eu-west-2",
  });
  
  const fileFilter = (req, file, cb) => {
    if (file.mimetype === "image/jpeg" || file.mimetype === "image/png") {
      cb(null, true);
    } else {
      cb(new Error("Invalid file type, only JPEG and PNG is allowed!"), false);
    }
  };
  
  const upload = multer({
    fileFilter,
    storage: multerS3({
      acl: "public-read",
      s3,
      bucket: "ichelloworld",
      metadata: function (req, file, cb) {
        const ext = file.mimetype.split('/')[1];
        cb(null, { fieldName: '${file.fieldname}.${ext}'});
      },
      key: function (req, file, cb) {
        cb(null, Date.now().toString());
      },
    }),
  });
  
  module.exports = upload;