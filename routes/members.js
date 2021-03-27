const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const config = require('config');
const { check, validationResult } = require('express-validator');
const normalize = require('normalize-url');

const User = require("../models/User");
const Group = require("../models/Group");
const Member = require("../models/Member");

router.post(
    '/',
    [
        check('user', 'User is required').not().isEmpty(),
        check('group', 'Group is required').not().isEmpty()
    ],
    async(req, res) => {
        const errors = validationResult(req);
        if(!errors.isEmpty()) {
          return res.status(400).json({ errors: errors.array() });
        }

        const { user, group } = req.body;

        try {
          let user = await User.findOne({ user });

          if(!user) {
            return res
              .status(400)
              .json({ errors: [{ msg: 'User does not exist' }] });
          }

          let group = await Group.findOne({ group });

          if(!group) {
            return res
              .status(400)
              .json({ errors: [{ msg: 'Group does not exist' }] });
          }

          member = new Member({
            user, 
            group
          });

          await member.save();

          const payload = {
            member: {
              id: member.id
            }
          };

          jwt.sign(
            payload,
            config.get('jwtSecret'),
            { expiresIn: '5 days' },
            (err, token) => {
              if (err) throw err;
              res.json({ token });
            }
          );
        } catch (err) {
          console.error(err.message);
          res.status(500).send('Server error');
        }
      }
  );

  module.exports = router;