#!/bin/bash

# Set the source and output directories
src_dir="src"
out_dir="out"

# Create the output directory if it doesn't exist
mkdir -p "$out_dir"

# Find all .md files under the source directory and count them
total_files=$(find "$src_dir" -type f -name "*.md" | wc -l)

# Initialize a counter
counter=0

find "$src_dir" -type f -name "*.md" | while read -r file; do
    # Increment the counter
    counter=$((counter + 1))

    # Print the status
    echo "Processing file $counter of $total_files"

    # Get the relative path of the file
    rel_path="${file#$src_dir/}"

    # Create the output directory structure
    out_subdir="$(dirname "$rel_path")"
    mkdir -p "$out_dir/$out_subdir"

    # Convert the .md file to PDF using pandoc
    pandoc "$file" -o "$out_dir/${rel_path%.md}.pdf"
done