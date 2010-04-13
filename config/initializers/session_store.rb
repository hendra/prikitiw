# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_prikitiw_session',
  :secret      => '91fb7ab90a7dd973737154b27392c6d0e32155ff895d9c7dbce9224e8d140814f2d5c44cb87e327f6c5b3207c111f8884e72f3d9440d760fea8956c6cc12c0d9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
