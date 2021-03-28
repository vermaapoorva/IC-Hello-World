const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const GoalSchema = new Schema({
  group: {
    type: Schema.Types.ObjectId,
    required: true
  },
  name: {
    type: String,
    required: true
  },
  // icon: {
  //   type: String
  // },
  description: {
    type: String
  },
  frequency: {
    type: String
  },  
});

module.exports = mongoose.model('goal', GoalSchema);