#!/bin/bash
TARGET_DIR="./tel"
SEARCH_STRING="vinayak"
REPLACE_STRING="Ajinkya"

grep -rl "$SEARCH_STRING" "$TARGET_DIR" | xargs sed -i "s/$SEARCH_STRING/$REPLACE_STRING/g"
