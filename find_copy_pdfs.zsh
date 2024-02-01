#!/bin/zsh

echo "Starting to search for PDF files in the filesystem..."
setopt EXTENDED_GLOB

cd ~
pdfs=( ~/**/*.pdf(.N) )

num_pdfs=${#pdfs[@]}

if [ "$num_pdfs" -eq 0 ]; then
    echo "No PDF files found in the user's home directory."
else
    echo "Found $num_pdfs PDFs. Copy to current directory? Y/N"
    read answer
    if [[ $answer =~ ^[Yy]$ ]]; then
        mkdir -p pdfs_i_found_for_you
        counter=0
        for file in "${pdfs[@]}"; do
            let counter++
            echo "Copying $file to '~/pdfs_i_found_for_you'..."
            cp "$file" ~/pdfs_i_found_for_you/
            echo "Done ($counter/$num_pdfs)"
            # progress indicator
            percent=$(( $counter * 100 / $num_pdfs))
            printf "\rProgress: [%-50s] %d%% " $(repeat $((percent / 2)) "=") $percent

        done
        echo "Yay! Yippee! All selected PDF files have been copied to '~/pdfs_i_found_for_you'."
    else
        echo "Copy operation aborted :("
    fi
fi