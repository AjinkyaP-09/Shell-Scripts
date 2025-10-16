#!/bin/bash

find /var/log/*.log -mtime -7 >logfilelist.txt

while IFS="/" read val3 val1 val2 filename; do
    tar -czf logarchives/$filename.tar.gz $val3/$val1/$val2/$filename
done <logfilelist.txt
