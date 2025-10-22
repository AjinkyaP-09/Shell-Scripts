#####################################################################
# Script Name : 01_LIST_AND_BACKUP_V2.sh
# Version :2.0
# Date : 18 Oct 2025
# Credit : Team CloudEthiX
# Purpose : List files in a directory and save output to a file.
####################################################################

# Write a shell script that lists all files in a specified directory and
# saves the output to a text file.

#!/bin/bash

DIR_PATH=$1
DIR_CONT="/home/ajinkya/directory_content.txt"

if [[ $# != "1" ]]; then
    echo "Script requires at least 1 Argument."
    echo "Usage: $0 DIR_PATH"
    exit 1
else
    if [[ -e $DIR_PATH && -d $DIR_PATH ]]; then
        LIST="$(ls -A $DIR_PATH)"
        if [[ -z "$LIST" ]]; then
            echo "Directory is empty. "
        else
            #            echo "Content of Directory $DIR_PATH: "
            #            echo $LIST
            echo "$LIST" >$DIR_CONT
            echo "The output is saved at /home/ajinkya/directory_content.txt"
        fi
    else
        echo "Directory does not exist or specified path is not a directory. Give correct path."
    fi
fi
