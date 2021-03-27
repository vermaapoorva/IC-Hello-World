const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const FriendSchema = new Schema({
  user1: {
    type: Schema.Types.ObjectId
  },
  user2: {
    type: Schema.Types.ObjectId
  }
});

module.exports = mongoose.model('friend', FriendSchema);