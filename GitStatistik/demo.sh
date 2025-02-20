# If no argument is given, use yesterday's date
if [ -z "$1" ]; then
  date=$(date -v-1d "+%Y-%m-%d")  # Get yesterday's date in YYYY-MM-DD format
else
  date=$1  # Use the date passed as an argument
fi

echo "Date: $date"