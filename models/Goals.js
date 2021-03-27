const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const GoalSchema = new Schema({
  group: {
    type: Schema.Types.ObjectId
  },
  name: {
    type: String,
    required: true
  },
  icon: {
    type: String
  },
  descripion: {
    type: String
  },
  frequency: {
    type: String
  },  
});

module.exports = mongoose.model('goal', GoalSchema);