#!/bin/bash
set -e

DB="test.db"
rm -f $DB

# Recreate the database with initial data
sqlite3 $DB < 1.sql

# Run the update query
sqlite3 $DB < 2.sql

# Dump updated data for Alex Smith
sqlite3 $DB "SELECT * FROM user_data WHERE User_Name = 'Alex Smith';" > student_output.txt

# Expected output after the update
cat <<EOF > expected_output.txt
4|sky_wanderer|Alex Smith|30|Male|2018-11-04|200|900|350|300
EOF

# Compare learner output to expected
if diff -q student_output.txt expected_output.txt >/dev/null; then
  echo "✅ Test Passed: Age updated correctly for Alex Smith"
  exit 0
else
  echo "❌ Test Failed: Output mismatch"
  diff student_output.txt expected_output.txt
  exit 1
fi
