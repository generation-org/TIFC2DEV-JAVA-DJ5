#!/bin/bash
set -e

DB="test.db"
rm -f $DB

# Recreate the database with initial data
sqlite3 $DB < 1.sql

# Run the SELECT query
sqlite3 $DB < 8.sql > student_output.txt

# Expected output: Users with Likes > 500 AND Posts > 80
cat <<EOF > expected_output.txt
3|neon_ninja|Jordan Lee|25|Other|2021-02-10|95|600|250|220
4|sky_wanderer|Alex Smith|32|Male|2018-11-04|200|900|350|300
5|sunset_lover|Taylor Brown|27|Female|2017-09-01|150|800|400|380
EOF

# Compare learner output to expected
if diff -q student_output.txt expected_output.txt >/dev/null; then
  echo "✅ Test Passed: Correct records with Likes > 500 AND Posts > 80 retrieved"
  exit 0
else
  echo "❌ Test Failed: Output mismatch"
  diff student_output.txt expected_output.txt
  exit 1
fi
