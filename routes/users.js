const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth');
const { check, validationResult } = require('express-validator');
// const normalize = require('normalize-url');

const User = require('../models/User');

// Create a new user
router.post(
  '/',
  [
    check('username', 'Username is required').not().isEmpty(),
    check('name', 'Name is required').not().isEmpty(),
    check('email', 'Please include a valid email').isEmail(),
    check(
      'password',
      'Please enter a password with 6 or more characters'
    ).isLength({ min: 6 })
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { username, name, email, password } = req.body;

    try {

      let user = await User.findOne({ username })

      if (user) {
        return res
          .status(400)
          .json({ errors: [{ msg: 'Username already exists' }] });
      }

      user = new User({
        username,
        name,
        email,
        password
      });

      const salt = await bcrypt.genSalt(10);

      user.password = await bcrypt.hash(password, salt);

      await user.save();

      const payload = {
        user: {
          id: user.id
        }
      };

      jwt.sign(
        payload,
        process.env.jwtSecret,
        { expiresIn: '5 days' },
        (err, token) => {
          if (err) throw err;
          res.json({ token: token, userid: user.id });
        }
      );
    } catch (err) {
      console.error(err.message);
      res.status(500).send('Server error');
    }
  }
);

// Delete a user by id
router.delete('/', auth, async(req, res) => {
  try {
    await User.findOneAndRemove({ user: req.user.id });
    await UserGoal.deleteMany({ userid: req.user.id });
    await Member.deleteMany({ user: req.user.id });
    await Friend.deleteMany({ user1: req.user.id });
    await Friend.deleteMany({ user2: req.user.id });

    let groupsOwnedByUser = await Group.find({ creator: req.user.id });
    
    // reassign the creator of the group
    for(var i = 0; i < groupsOwnedByUser.length; i++) {
      var group = groupsOwnedByUser[i];
      // find a user that isn't the current creator 
      let user = await Member.findOne({ group: group.id }).where(user).ne(req.user.id);
      if(!user) {
        // if another user doesn't exist, delete the group
        await Group.findOneAndRemove({ id: group.id })
        await Member.deleteMany({ group: group.id });
      } else {
        // else reassign to the user
        group.creator = user.id;
        await group.save();
      }
    }

    res.json({ msg: 'User deleted'});
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
});

// get profile by id
router.get('/userid/:userid', auth, async({ params: { userid }}, res) => {
  try {
    let user = await User.findOne({ _id: userid });
    res.json(user);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
});

// get profiles by username
router.get('/username/:username', auth, async(req, res) => {
  try {
    console.log("here")
    console.log(req.params)
    let users = await User.find({username: {$regex: req.params.username, $options: "i"} });
    // let users = await User.find({ $text: {$search: req.params.username }}).select('-password');
    res.json(users);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
});

module.exports = router;