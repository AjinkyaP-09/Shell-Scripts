#!/bin/bash
read -p "Enter directory path: " DIR
read -p "Enter pattern: " PATTERN
find $DIR -name "$PATTERN" -type f -delete
