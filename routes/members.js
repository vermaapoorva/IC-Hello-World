const express = require("express");
const router = express.Router();
const jwt = require("jsonwebtoken");
const config = require("config");
const auth = require("../middleware/auth");
const { check, validationResult } = require("express-validator");
// const normalize = require('normalize-url');

const User = require("../models/User");
const Group = require("../models/Group");
const Member = require("../models/Member");
const Goal = require("../models/Goal");
const UserGoal = require("../models/UserGoal");

// Add member to group
router.post(
  "/",
  auth,
  [
    check("userId", "User is required").not().isEmpty(),
    check("groupId", "Group is required").not().isEmpty(),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { userId, groupId } = req.body;

    try {
      console.log(userId);
      let user = await User.findById(userId);

      if (!user) {
        return res
          .status(400)
          .json({ errors: [{ msg: "User does not exist" }] });
      }

      let group = await Group.findById(groupId);

      if (!group) {
        return res
          .status(400)
          .json({ errors: [{ msg: "Group does not exist" }] });
      }

      let findMember = await Member.findOne({ user: userId, group: groupId });

      if (findMember) {
        return res.status(400).json({
          msg: "User/Group Member Combination already exists",
        });
      }

      member = new Member({
        user: user.id,
        group: group.id,
      });

      await member.save();

      let goals = await Goal.find({ groupid: groupId }).select('_id');
      var date = new Date();

      for(var i = 0; i < goals.length; i++) {
        if(goals[i].frequency == 'daily') {
          // resets just has to be today
        } else if(goals[i].frequency == 'weekly') {
          var day = date.getDay();
          if(day != 0) date.setDate(date.getDate()+(7-day));
        } else if(goals[i].frequency == 'monthly') {
          date.setDate(date.getFullYear(), date.getMonth() + 1, 1);
          date.setDate(date - 1);
        }

        var userGoal = new UserGoal({
          user: user.id, 
          goals: goals[i].id, 
          resets: date});
        
        await userGoal.save();
      }

      res.send(member);
    } catch (err) {
      console.error(err.message);
      res.status(500).send("Server error");
    }
  }
);

router.delete("/", auth, async (req, res) => {
  try {
    const { userId, groupId } = req.body;
    console.log(userId, groupId);
    if (!(await Member.findOneAndRemove({ user: userId, group: groupId }))) {
      return res.json({ msg: "User/Group Member Combination doesn't exist." });
    }

    await UserGoal.deleteMany({ userid: userId });

    let member = await Member.findOne({ group: groupId });

    if (!member) {
      await Group.findOneAndRemove({ _id: groupId });
    }

    res.json({ msg: "User removed from group" });
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
});

module.exports = router;
