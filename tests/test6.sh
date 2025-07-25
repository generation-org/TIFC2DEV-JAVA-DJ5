#!/bin/bash
set -e

DB="test.db"
rm -f $DB

# Recreate the database with initial data
sqlite3 $DB < 1.sql

# Run the SELECT query
sqlite3 $DB < 6.sql > student_output.txt

# Expected output
cat <<EOF > expected_output.txt
2|zen_master|Chris Roberts|30|Male|2019-12-20|80|300|150|180
4|sky_wanderer|Alex Smith|32|Male|2018-11-04|200|900|350|300
EOF

# Compare learner output to expected
if diff -q student_output.txt expected_output.txt >/dev/null; then
  echo "✅ Test Passed: Correct records with Gender = 'Male' retrieved"
  exit 0
else
  echo "❌ Test Failed: Output mismatch"
  diff student_output.txt expected_output.txt
  exit 1
fi
