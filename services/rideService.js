const supabase = require('../db');

const RideService = {
  // 1. Create a Ride (The Bus)
  async createRide(rideData) {
    const { data, error } = await supabase
      .from('rides')
      .insert([rideData])
      .select();
    
    if (error) throw new Error(error.message);
    return data[0];
  },

  // 2. Get Rides with Filters (Source/Dest)
  async getOpenRides(source, destination) {
    let query = supabase
      .from('rides')
      .select('*, drivers(full_name, review_score)') // Join Driver info automatically
      .eq('status', 'OPEN'); // Only show open rides

    if (source) query = query.ilike('source_name', `%${source}%`);
    if (destination) query = query.ilike('dest_name', `%${destination}%`);

    const { data, error } = await query;
    if (error) throw new Error(error.message);
    return data;
  },

  // 3. Update Ride Status (e.g., Cancelled, Full)
  async updateRideStatus(rideId, newStatus) {
    const { data, error } = await supabase
      .from('rides')
      .update({ status: newStatus })
      .eq('ride_id', rideId)
      .select();
    
    if (error) throw new Error(error.message);
    return data[0];
  }
};

module.exports = RideService;