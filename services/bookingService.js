const supabase = require('../db');

const BookingService = {
  // 1. Create a Booking (The Ticket)
  // This is the "Atomic" transaction we discussed.
  // Note: Supabase JS doesn't support complex transactions easily like raw SQL.
  // For basic use, we insert directly.
  async createBooking(bookingData) {
    const { data, error } = await supabase
      .from('bookings')
      .insert([bookingData])
      .select();

    if (error) throw new Error(error.message);
    return data[0];
  },

  // 2. Get all bookings for a specific User (My Ride History)
  async getUserBookings(userId) {
    const { data, error } = await supabase
      .from('bookings')
      .select('*, rides(*)') // Get the booking AND the ride details
      .eq('user_id', userId);
    
    if (error) throw new Error(error.message);
    return data;
  },

  // 3. Update a Booking by bookingId
  async updateBooking(bookingId, bookingData) {
    const { data, error } = await supabase
      .from('bookings')
      .update(bookingData)
      .eq('id', bookingId)
      .select();

    if (error) throw new Error(error.message);
    return data[0];
  }

};

module.exports = BookingService;