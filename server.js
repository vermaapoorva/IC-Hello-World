const express = require('express');
const connectDB = require('./config/db');
const app = express();
const cors = require("cors");

connectDB()

app.use(express.json());
app.use(cors());


app.get('/', function (req, res) {
    res.send('hello world')
})

// Define Routes
app.use('/users', require('./routes/users'));
app.use('/groups', require('./routes/groups'));
app.use('/friends', require('./routes/friends'));
app.use('/goals', require('./routes/goals'));
app.use('/members', require('./routes/members'));
app.use('/auth', require('./routes/auth'));
// app.use('/upload', require('./routes/uploadImage'));

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => console.log(`Server started on port ${PORT}`));