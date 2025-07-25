#!/bin/bash
set -e

DB="test.db"
rm -f $DB

# Recreate the database with initial data
sqlite3 $DB < 1.sql

# Run the SELECT query
sqlite3 $DB < 4.sql > student_output.txt

# Expected output
cat <<EOF > expected_output.txt
starlight_dancer
zen_master
neon_ninja
sky_wanderer
sunset_lover
EOF

# Compare learner output to expected
if diff -q student_output.txt expected_output.txt >/dev/null; then
  echo "✅ Test Passed: Correct Account_Names retrieved"
  exit 0
else
  echo "❌ Test Failed: Output mismatch"
  diff student_output.txt expected_output.txt
  exit 1
fi
