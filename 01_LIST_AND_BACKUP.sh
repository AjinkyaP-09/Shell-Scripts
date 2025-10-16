#!/bin/bash
read -p "Enter the path to list the content: " S_PATH
LIST="$(ls -A $S_PATH)"
if [[ -z "$LIST" ]]; then
    echo "Directory is empty" >directory_content.txt
else
    echo "$LIST" >directory_content.txt
fi

#echo "File named directory_content.txt is created in current directory containing inflo of listing."
