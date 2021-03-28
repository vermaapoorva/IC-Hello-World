const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const config = require('config');
const auth = require('../middleware/auth');
const { check, validationResult } = require('express-validator');
// const normalize = require('normalize-url');

const User = require('../models/User');
const Friend = require('../models/Friend');

router.post(
    '/',
    auth,
    [
        check('user1', 'User 1 is required').not().isEmpty(),
        check('user2', 'User 2 is required').not().isEmpty()
    ],
    async (req, res) => {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }

      const { user1, user2 } = req.body;

      try {
        let u1 = await User.findOne({ user1 }).select("-password");

        if(!u1) {
          return res
            .status(400)
            .json({ errors: [{ msg: 'First given user not found' }] });         
        }

        let u2 = await User.findOne({ user2 });

        if(!u2) {
          return res
            .status(400)
            .json({ errors: [{ msg: 'Second given user not found' }] });
        }

        friend = new Friend({
          user1, 
          user2
        });

        await friend.save();
      } catch (err) {
        console.error(err.message);
        res.status(500).send('Server error');
      }
    }
);

// get friends by userid
router.get('/:userid', auth, async({ params: { userid }}, res) => {
  try {
    let friends = await Friend.find({$or: [{$user1: userid}, {$user2: userid}]});

    var userids = new Array(friends.length);

    for(var i = 0; i < friends.length; i++) {
      if(friends.user1 == userid) {
        userids[i] = friends.user2;
      } else {
        userids[i] = friends.user1;
      }
    }

    let users = await User.findById({$in: userids}).select("-password");
  
    res.json(users);
  } catch (err) {
    console.error(err.message);
    return res.status(500).json({ msg: 'Server error' });
  }
});

router.delete('/', auth, async(req, res) => {
  try {
    const {user1, user2} = req.body;
    await Friend.findOneAndRemove({$or: [{ user1: user1 }, { user2: user2 }]});

    res.json({ msg: 'Removed friend'});
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
});

module.exports = router;