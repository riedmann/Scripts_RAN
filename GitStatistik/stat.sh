#!/bin/bash



if [ -z "$1" ]; then
  date=$(date -v-1d "+%Y-%m-%d")  # Get yesterday's date in YYYY-MM-DD format
else
  date=$1  # Use the date passed as an argument
fi




# Get all directories in the current folder
for folder in */; do
  # Check if it's a directory and contains a .git folder
  if [ -d "$folder/.git" ]; then
    echo ""
    echo "-----------------------"
    echo "Start checking $folder"
    echo "-----------------------"
    cd "$folder" || exit
    gitstate.sh $date $folder

    cd ..
  else
    echo "$folder is not a Git repository"
  fi
done
