require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_KEY;

// Create a single instance of the client to be used everywhere
const supabase = createClient(supabaseUrl, supabaseKey);

module.exports = supabase;