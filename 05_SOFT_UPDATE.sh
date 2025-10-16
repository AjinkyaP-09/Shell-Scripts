#!/bin/bash
CHECK_UPDATE="$(yum check-update -q)"
if (($? == 100)); then
    echo "Installing updates..."
    yum update -y >/dev/null 2>&1
    echo "Updates installed."
else
    echo "There are no updates. All softwares are updated."
fi
