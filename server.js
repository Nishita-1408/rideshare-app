const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();

// Import Services
const UserService = require('./services/userService');
const RideService = require('./services/rideService');
const BookingService = require('./services/bookingService');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// --- USER ROUTES ---

app.post('/users', async (req, res) => {
    console.log("Creating user with data:", req.body);
  try {
    const newUser = await UserService.createUser(req.body);
    res.status(201).json(newUser);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

app.get('/users/:firebaseUid', async (req, res) => {
  try {
    const user = await UserService.getUserByFirebaseId(req.params.firebaseUid);
    if (!user) return res.status(404).json({ error: "User not found" });
    res.json(user);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});