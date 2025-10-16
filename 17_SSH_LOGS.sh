#!/bin/bash
cat /var/log/secure | grep 'failed' >failed_ssh.txt
echo "Done"
