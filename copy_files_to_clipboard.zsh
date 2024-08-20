#!/bin/zsh

# Define the first and second target directories
dir1="${1:-.}"
dir2="${2:-.}"

# Initialize an empty string to hold all the content
combined_content=""

# Function to process a directory and append its contents
process_directory() {
  local target_directory="$1"
  find "$target_directory" -type f | while read -r file; do
    # Get the relative path of the file
    relative_path="${file#$target_directory/}"

    # Add the file path as a comment and the file content
    combined_content+="\n//${relative_path}\n"
    combined_content+=$(<"$file")
    combined_content+="\n"
  done
}

# Process both directories
process_directory "$dir1"
process_directory "$dir2"

# Copy the combined content to the clipboard
echo -e "$combined_content" | pbcopy

# Notify the user
echo "Contents of $dir1 and $dir2 copied to clipboard."
