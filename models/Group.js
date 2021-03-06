const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const GroupSchema = new mongoose.Schema({
    name: {
      type: String,
      required: true
    },
    description: {
        type: String
    },
    creator: {
      type: Schema.Types.ObjectId
    }
  });
  
  module.exports = mongoose.model('group', GroupSchema);