const supabase = require('../db');

const UserService = {
  // 1. Create a new user (Linked to Firebase UID)
  async createUser(userData) {
    // userData expects: { firebase_uid, full_name, email, roll_no, gender }
    const { data, error } = await supabase
      .from('users')
      .insert([userData])
      .select(); // Returns the created row
    
    if (error) throw new Error(error.message);
    return data[0];
  },

  // 2. Get User by their Firebase UID (Used during Login)
  async getUserByFirebaseId(firebaseUid) {
    const { data, error } = await supabase
      .from('users')
      .select('*')
      .eq('firebase_uid', firebaseUid)
      .single();
    
    if (error) return null; // Return null if not found
    return data;
  }
};

module.exports = UserService;