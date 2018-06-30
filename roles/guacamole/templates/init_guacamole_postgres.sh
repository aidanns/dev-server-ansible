#!/usr/bin/env bash

# Author: Aidan Nagorcka-Smith (aidanns@gmail.com)

# Only execute if the database doesn't exist.
if ! psql -c "\l" | grep guacamole_db > /dev/null; then
  # Create the database.
  createdb guacamole_db

  # Run the init SQL.
  psql -d guacamole_db -f /initdb.sql

  # Grant permissions for our user on the database.
  psql -d guacamole_db -c "CREATE USER guacamole_user WITH PASSWORD 'password'"
  psql -d guacamole_db -c "GRANT SELECT,INSERT,UPDATE,DELETE ON ALL TABLES IN SCHEMA public TO guacamole_user"
  psql -d guacamole_db -c "GRANT SELECT,USAGE ON ALL SEQUENCES IN SCHEMA public TO guacamole_user"
fi


