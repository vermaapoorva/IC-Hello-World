const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const MemberSchema = new mongoose.Schema({
    user: {
        type: Schema.Types.ObjectId,
        required: true
    },
    group: {
        type: Schema.Types.ObjectId,
        required: true
    }
  });
  
  module.exports = mongoose.model('member', MemberSchema);