#!/bin/bash

output_file="git_commits.log"
> "$output_file"  # Clear the file before writing new data

for dir in */; do
    if [ -d "$dir/.git" ]; then
        echo "Processing $dir..."
        echo "Repository: $dir" >> "$output_file"

        # Navigate into the repository
        cd "$dir" || continue

        # Pull latest changes
        git pull >> /dev/null 2>&1  # Suppress output to keep it clean

        # Get last 10 commits (date and title)
        git log -10 --pretty=format:"%ad - %s" --date=short >> "../$output_file"
        echo "" >> "../$output_file"  # Add a newline for readability

        # Return to parent directory
        cd ..
    fi
done

echo "Done! Check $output_file for results."
