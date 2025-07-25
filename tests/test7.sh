#!/bin/bash
set -e

DB="test.db"
rm -f $DB

# Recreate the database with initial data
sqlite3 $DB < 1.sql

# Run the SELECT query
sqlite3 $DB < 7.sql > student_output.txt

# Expected output: Account_Names starting with 's'
cat <<EOF > expected_output.txt
1|starlight_dancer|Emma Johnson|28|Female|2020-05-15|120|450|200|150
4|sky_wanderer|Alex Smith|32|Male|2018-11-04|200|900|350|300
5|sunset_lover|Taylor Brown|27|Female|2017-09-01|150|800|400|380
EOF

# Compare learner output to expected
if diff -q student_output.txt expected_output.txt >/dev/null; then
  echo "✅ Test Passed: Correct Account_Names starting with 's' retrieved"
  exit 0
else
  echo "❌ Test Failed: Output mismatch"
  diff student_output.txt expected_output.txt
  exit 1
fi
