const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();
const supabase = require('./db');

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

// POST /rides/create-transaction
app.post('/rides/create-transaction', async (req, res) => {
  try {
    // 1. Extract the data sent by the Flutter app
    const { 
      host_user_id, 
      driver_id, 
      source_name, 
      dest_name, 
      departure_time, 
      total_seats 
    } = req.body;

    // 2. Call the Postgres function via RPC (Remote Procedure Call)
    // This is 100% ACID compliant.
    const { data: newRideId, error } = await supabase.rpc('create_ride_with_booking', {
      host_user_id: host_user_id,
      p_driver_id: driver_id,
      p_source_name: source_name,
      p_dest_name: dest_name,
      p_departure_time: departure_time,
      p_total_seats: total_seats
    });

    // 3. Handle Database Errors (e.g., invalid UUIDs or missing data)
    if (error) {
      console.error("Transaction Failed:", error.message);
      return res.status(400).json({ error: error.message });
    }

    // 4. Success Response
    res.status(201).json({
      message: "Ride and Host Booking created successfully!",
      ride_id: newRideId
    });

  } catch (err) {
    // Handle Server Errors
    console.error("Server Error:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});