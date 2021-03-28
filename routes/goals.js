const express = require("express");
const router = express.Router();
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");
const { check, validationResult } = require("express-validator");

const User = require("../models/User");
const Goal = require("../models/Goal");
const UserGoal = require("../models/UserGoal");
const Member = require("../models/Member");
const Group = require("../models/Group");

router.post(
  "/",
  auth,
  [
    check("goalname", "Goalname is required").not().isEmpty(),
    check("frequency", "Frequency is required").not().isEmpty(),
    check("groupid", "GroupId is required").not().isEmpty(),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { groupid, goalname, frequency, description } = req.body;

    try {
      goal = new Goal({
        group: groupid,
        name: goalname,
        description,
        frequency,
      });

      await goal.save();

      let members = await Member.find({ group: groupid });
      console.log(members);
      for (var i = 0; i < members.length; i++) {
        console.log(members[i].user);
        let user = await User.findById(members[i].user);
        if (user) {
          addUserGoal(user.id, goal.id);
        }
      }

      res.send(goal);
    } catch (err) {
      console.error(err.message);
      res.status(500).send("Server error");
    }
  }
);

const addUserGoal = async (userId, goalId) => {
  let dbgoal = await Goal.findById(goalId);

  var date = new Date();

  if (dbgoal) {
    if (dbgoal.frequency == "daily") {
      // resets just has to be today
    } else if (dbgoal.frequency == "weekly") {
      // set the resets date to next Sunday
      var day = date.getDay();
      if (day != 0) date.setDate(date.getDate() + (7 - day));
    } else if (dbgoal.frequency == "monthly") {
      date.setDate(date.getFullYear(), date.getMonth() + 1, 1);
      date.setDate(date - 1);
    }
  }

  try {
    userGoal = new UserGoal({
      userid: userId,
      goalid: goalId,
      resets: date,
    });
    await userGoal.save();
  } catch (err) {
    console.error(err.message);
    // res.status(500).send('Server error');
  }
};

// sets the completed boolean for a particular user goal
router.post(
  "/complete/",
  auth,
  [
    check("userId", "User ID required").not().isEmpty(),
    check("goalId", "Goal ID required").not().isEmpty(),
    check("set", "Set Boolean Required").not().isEmpty(),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { userId, goalId, set } = req.body;

    try {
      let goal = await UserGoal.find({ userid: userId, goalid: goalId });

      if (!goal) {
        return res
          .status(400)
          .json({ errors: [{ msg: "Couldn't find the goal" }] });
      }

      goal.completed = set;
      await goal.save();
    } catch (err) {
      console.error(err.message);
      res.status(500).send("Server Error");
    }
  }
);

// get goal, group for a goal 
router.get("/goalid/:goalId", auth, async ({params: { goalId }}, res) => {
  try {
    let goal = await Goal.findOneById(goalId);
    
    if(!goal) {
      return res.status(400).json({ errors: [{ msg: "Couldn't find the given goal" }] });
    }

    let group = await Group.findOneById(goal.groupid);
  
    res.json(goal, group);    
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
});

router.post('/update', 
            auth,
            [
              check('goalId', 'Goal Id must be given').not().isEmpty(),
              check('goalName', "Goal name must be given").not().isEmpty(),
              check('frequency', "Frequency must be given").not().isEmpty()
            ], async(req, res) => {
              try {
                const { goalid, goalname, frequency } = req.body;
                let goal = await Goal.findById(goalid);

                if(!goal) {
                  res.status(400).json({errors: [{msg: "Couldn't find the given goal"}] });
                }

                goal.goalname = goalname;
                goal.frequency = frequency;

                await goal.save();

                let usergoals = await UserGoal.find({goalid: goalid});

                for(var i = 0; i < usergoals.length; i++) {
                  updateGoal(userGoal);
                }

                res.send("done");
              } catch (err) {
                console.error(err.message);
                res.status(500).send("Server Error");
              }
            }); 

// get all goals for a userid
router.get("/userid/:userId", auth, async ({ params: { userId } }, res) => {
  try {
    let usergoals = await UserGoal.find({ userid: userId });

    console.log(usergoals);

    var list = []

    for (const usergoal of usergoals) {
      updateGoal(usergoal)
      const goal = await Goal.findById(usergoal.goalid)
      console.log(goal)
      list.push({
        "goalid" : usergoal.goalid,
        "completed" : usergoal.completed,
        "groupid": goal.groupid,
        "name" : goal.name,
        "description" : goal.description,
        "frequency" : goal.frequency
      })
      console.log(list)
    }

    res.send(list)

  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
});

function extend(dest, src) { 
  for(var key in src) { 
      dest[key] = src[key]; 
  } 
  return dest; 
} 

function updateGoal(usergoal) {
  var date = new Date();
  if (usergoal.resets < date) {
    usergoal.completed = false;
    let dbgoal = Goal.find({ id: usergoal.goalid });

    if (dbgoal) {
      if (dbgoal.frequency == "weekly") {
        // set the resets date to next Sunday
        var day = date.getDay();
        if (day != 0) date.setDate(date.getDate() + (7 - day));
      } else if (dbgoal.frequency == "monthly") {
        date.setDate(date.getFullYear(), date.getMonth() + 1, 1);
        date.setDate(date - 1);
      }

      usergoal.resets.setDate(date);
      usergoal.completed = false;
      usergoal.save();
    }
  }
}

router.delete("/", auth, async (req, res) => {
  try {
    const { goalId } = req.body;
    await Goal.findOneAndRemove({ _id: goalId });
    await UserGoal.deleteMany({ goalid: goalId });

    res.json({ msg: "Goal Deleted" });
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
});

module.exports = router;
