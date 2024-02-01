#!/bin/zsh

echo "Starting to search for PDF files in the filesystem..."
setopt EXTENDED_GLOB

cd ~
pdfs=( ~/**/*.pdf(.N) )

num_pdfs=${#pdfs[@]}

output_file="foundPdfs.txt"

for pdf in $pdfs; do
    echo "$pdf" >> ~/"$output_file"
done

if [ "$num_pdfs" -eq 0 ]; then
    echo "No PDF files found in the user's home directory."
else
    echo "Found $num_pdfs PDFs. Copy to current directory? Y/N"
    read answer
    if [[ $answer =~ ^[Yy]$ ]]; then
        mkdir -p pdfs_i_found_for_you
        counter=0
        for file in "${pdfs[@]}"; do
            (( counter++ ))
            cp "$file" ~/pdfs_i_found_for_you/ 2>/dev/null
            
            # progress indicator
            percent=$(( $counter * 100 / $num_pdfs))
            num_equals=$((percent / 2))
            progress_bar=$(printf '%*s' "$num_equals" '' | tr ' ' '=')
            printf "\rProgress: [%-50s] %d%% " "$progress_bar" "$percent"
        done
        echo -e "\n Yay! Yippee! All selected PDF files have been copied to '~/pdfs_i_found_for_you'."
    else
        echo "Copy operation aborted :("
    fi
fi