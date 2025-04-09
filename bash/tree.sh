#!/usr/bin/env bash
# A simple recursive bash script to display a directory tree,
# along with a summary count of directories and files.
#
# Usage: ./tree.sh [directory]
# If no directory is provided, it defaults to the current directory.

# Global counters for directories and files.
total_dirs=0
total_files=0

# Recursive function to print the tree structure.
tree() {
    local dir="$1"
    local prefix="$2"

    # List all entries (files and directories) inside $dir.
    # Using '*' will not return hidden files.
    local entries=("$dir"/*)
    local count=${#entries[@]}
    local i=0

    for entry in "${entries[@]}"; do
        # If the entry doesn't exist, skip it (handles empty directories).
        [ ! -e "$entry" ] && continue

        i=$(( i + 1 ))
        local base=$(basename "$entry")

        if [ "$i" -eq "$count" ]; then
            echo "${prefix}└── $base"
            new_prefix="${prefix}    "
        else
            echo "${prefix}├── $base"
            new_prefix="${prefix}│   "
        fi

        if [ -d "$entry" ]; then
            # Increase directory counter (not counting the root directory).
            total_dirs=$(( total_dirs + 1 ))
            tree "$entry" "$new_prefix"
        else
            # Increase file counter.
            total_files=$(( total_files + 1 ))
        fi
    done
}

# Use the provided argument as the directory (default to '.')
dir="${1:-.}"

# Print the root directory.
echo "$dir"

# Invoke the recursive function.
tree "$dir" ""

# Print a blank line followed by the summary.
echo ""
echo "$total_dirs directories, $total_files files"
