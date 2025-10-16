#!/bin/bash
read -p "Enter path to DIR1: " DIR1
read -p "Enter path to DIR2: " DIR2

diff -rq "$DIR1" "$DIR2"

if [ $? -eq 0 ]; then
    echo "No differences found between '$DIR1' and '$DIR2'."
elif [ $? -eq 1 ]; then
    echo "Differences found between '$DIR1' and '$DIR2'."
else
    echo "An error occurred during the comparison."
fi
