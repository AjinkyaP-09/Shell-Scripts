#!/bin/bash
while IFS=: read -r username _ uid gid _ homedir _; do
    if ((uid > 1000)); then
        find / -type d-name homedir -mtime -1
    fi
done <"/etc/passwd"
