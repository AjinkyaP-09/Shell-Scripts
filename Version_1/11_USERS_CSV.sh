#!/bin/bash

read -p "Enter CSV file path: " CSVFILE

while IFS=, read username fullname; do
    useradd -m -c "$fullname" "$username"
    if (($? == 0)); then
        echo "User $username added successfully."
    else
        echo "useradd failed"
    fi
done <$CSVFILE
