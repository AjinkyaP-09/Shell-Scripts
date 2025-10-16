#!/bin/bash
read -p "Enter directory path: " DIR
read -p "Name to change: " OLD_TEXT
read -p "Name to give: " NEW_NAME

find "$DIR" -maxdepth 1 -type f | while IFS= read -r file; do
    new_name=$(echo "$file" | sed "s/$OLD_TEXT/$NEW_NAME/g")
    if [ "$file" != "$new_name" ]; then
        echo "Renaming '$file' to '$new_name'"
        mv "$file" "$new_name"
    fi
done
