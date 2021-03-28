const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const UserGoalSchema = new mongoose.Schema({
    userid: {
      type: Schema.Types.ObjectId,
      required: true
    }, 
    goalid: {
      type: Schema.Types.ObjectId,
      required: true      
    },
    completed: {
      type: Boolean,
      default: false
    },
    resets: {
      type: Date,
      required: true
    }
});

module.exports = mongoose.model('usergoal', UserGoalSchema);