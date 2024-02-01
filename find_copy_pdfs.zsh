#!/bin/zsh

echo "Starting to search for PDF files in the filesystem..."

pdfs=($(find ~/ -type f -name '*.pdf' ! '*/Library/*' 2>/dev/null))

num_pdfs=${#pdfs[@]}

if [ "$num_pdfs" -eq 0 ]; then
    echo "No PDF files found in the user's home directory."
else
    echo "Found $num_pdfs PDFs. Copy to current directory? Y/N"
    read answer
    if [[ $answer =~ ^[Yy]$ ]]; then
        mkdir -p pdfs_i_found_for_you
        for file in "${pdfs[@]}"; do
            echo "Copying $file to the current directory..."
            cp "$file" ./pdfs_i_found_for_you
        done
        echo "Yay! Yippee! All selected PDF files have been copied to the current directory."
    else
        echo "Copy operation aborted :()"
    fi
fi