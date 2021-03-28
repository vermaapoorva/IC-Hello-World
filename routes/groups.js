const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth');
const { check, validationResult } = require('express-validator');

const Group = require('../models/Group');
const Member = require('../models/Member');
const User = require('../models/User');
const Goal = require('../models/Goal');

// Create a new group
router.post(
    '/',
    auth,
    [
        check('groupname', 'Group Name is required').not().isEmpty()
    ],
    async (req, res) => {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }   

      const { groupname } = req.body;
      
      try {

        group = new Group({
          name: groupname,
          creator: req.user.id
        });

        await group.save();

        member = new Member({
            user: group.creator,
            group: group.id
        });
    
        await member.save();

        res.send(group)

      } catch (err) {
        console.error(err.message);
        res.status(500).send('Server error');
      }
    }
);

// get a group by groupid
router.get('/groupId/:groupId', auth, async({ params: { groupId }}, res) => {
  try {
    let group = await Group.findById(groupId);
    var goals = await Goal.find({ groupid: groupId });
    var members = [];
    
    for(const member of (await Member.find({ group: groupId }).select('user'))) {
      let user = await User.findById(member.user).select('-password');
      members.push(user);
    };

    res.json({group, goals, members});

  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
});
  
// get all groups for a userid
router.get('/userid/:userid', auth, async({ params: { userid }}, res) => {
  try {
    var groups = []

    for(const member of (await Member.find({ user: userid }).select('group'))) {
      let group = await Group.findById(member.group);
      groups.push(group);
    }

    res.json(groups);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
});

// Delete a group by id
router.delete('/', auth, async(req, res) => {
  try {
    const {groupid} = req.body;
    await Group.findOneAndRemove({ _id: groupid });
    await Member.deleteMany({ group: groupid });

    let goals = await Goal.find({ groupid: groupid })

    for(var i = 0; i < goals.length; i++) {
      await UserGoal.deleteMany({ goalid: goals[i].id });
    }

    await Goal.deleteMany({ groupid: groupid });

    res.json({ msg: 'Group deleted' });
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
})

module.exports = router;