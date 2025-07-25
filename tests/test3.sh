#!/bin/bash
set -e

DB="test.db"
rm -f $DB

# Recreate the database with initial data
sqlite3 $DB < 1.sql

# Run the delete query
sqlite3 $DB < 3.sql

# Dump all data after deletion
sqlite3 $DB "SELECT * FROM user_data;" > student_output.txt

# Expected output after deleting 'Taylor Brown'
cat <<EOF > expected_output.txt
1|starlight_dancer|Emma Johnson|28|Female|2020-05-15|120|450|200|150
2|zen_master|Chris Roberts|30|Male|2019-12-20|80|300|150|180
3|neon_ninja|Jordan Lee|25|Other|2021-02-10|95|600|250|220
4|sky_wanderer|Alex Smith|32|Male|2018-11-04|200|900|350|300
EOF

# Compare learner output to expected
if diff -q student_output.txt expected_output.txt >/dev/null; then
  echo "✅ Test Passed: User 'Taylor Brown' deleted successfully"
  exit 0
else
  echo "❌ Test Failed: Output mismatch"
  diff student_output.txt expected_output.txt
  exit 1
fi
