#!/bin/bash

# Check if required parameters are provided
if [ -z "$1" ]; then
  echo "ATTENTION Usage: $0 <datefrom> <dateto> <foldername>"
  exit 1
else 
  fromDate="$1"
  toDate="$2"
  folder="$3"
fi



cd "$folder"

echo "User $folder"
echo "Date $fromDate"
echo "To Date $toDate"

echo ""
echo "pulling repo"
git pull

echo ""

echo ""
echo "all commits...since $fromDate"
git log --since="$fromDate" --until="$toDate" --format="%H"
echo ""


TEMP_OUTPUT_FILE="changes_temp_$1.txt"
git log --since="$fromDate" --until="$toDate" --format="%H" | while read commit_hash; do git show  "$commit_hash" ; done > "$TEMP_OUTPUT_FILE"

# # Get the commit hash since the provided date
# OLDEST_COMMIT=$(git log --since="$fromDate" --format="%H" | tail -1)
# echo "Oldest commit: $OLDEST_COMMIT"

# # Temporary output file for diff
# TEMP_OUTPUT_FILE="changes_temp_$1.txt"
# git show $OLDEST_COMMIT  > "$TEMP_OUTPUT_FILE"

# Count added lines (+) in the specified file
ADDED_LINES=$(grep -E "^\+" "$TEMP_OUTPUT_FILE" | grep -vcE "^\+\+\+")

# Count removed lines (-) in the specified file
REMOVED_LINES=$(grep -E "^-" "$TEMP_OUTPUT_FILE" | grep -vcE "^---")

# Final output file including added lines in name, saving to parent folder
OUTPUT_FILE="../${folder%/}_${fromDate}_to_${toDate}_added_${ADDED_LINES}.diff"
mv "$TEMP_OUTPUT_FILE" "$OUTPUT_FILE"

# Display results

echo "###############"
echo "Added lines: $ADDED_LINES"
echo "Removed lines: $REMOVED_LINES"
echo "###############"