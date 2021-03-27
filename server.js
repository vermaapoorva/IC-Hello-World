const express = require('express');
const connectDB = require('./config/db');

const app = express();

connectDB()

app.use(express.json());

app.get('/', function (req, res) {
    res.send('hello world')
})

// Define Routes
app.use('/users', require('./routes/users'));
// app.use('/groups', require('./routes/groups'));

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => console.log(`Server started on port ${PORT}`));