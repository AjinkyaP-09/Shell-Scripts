#!/bin/bash
REPORT_FILE="/tmp/new_users_report_$(date +%Y%m%d%H%M%S).txt"
CUTOFF_TIME=$(date -d "24 hours ago" +%s)
while IFS=: read -r username _ uid gid _ homedir _; do
    if ((uid < 1000)); then
        continue
    fi
    if [[ -d "$homedir" ]]; then
        HOME_DIR_MOD_TIME=$(stat -c %Y "$homedir")
        if ((HOME_DIR_MOD_TIME > CUTOFF_TIME)); then
            echo "User: $username (UID: $uid, Home: $homedir)" >>"$REPORT_FILE"
            echo "  Home directory created/modified: $(date -d "@$HOME_DIR_MOD_TIME")" >>"$REPORT_FILE"
        fi
    fi
done </etc/passwd
