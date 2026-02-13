const supabase = require('../db');

const DriverService = {

  async createDriver(driverData) {
    // driverData expects: { driver_id, full_name, contact, review_score=0}
    const { data, error } = await supabase
      .from('drivers')
      .insert([driverData])
      .select(); // Returns the created row
    
    if (error) throw new Error(error.message);
    return data[0];
  },

  // 2. Get Driver from driver id
  async getDriverByDriverId(driverId) {
    const { data, error } = await supabase
      .from('drivers')
      .select('*')
      .eq('driver_id', driverId)
      .single();
    
    if (error) return null; // Return null if not found
    return data;
  }
};

module.exports = DriverService;