const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const GroupSchema = new mongoose.Schema({
    name: {
      typ: String,
      required: true
    },
    creator: {
      type: Schema.Types.ObjectId
    }
  });
  
  module.exports = mongoose.model('group', GroupSchema);