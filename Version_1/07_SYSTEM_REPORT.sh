#!/bin/bash
touch report.txt
file=report.txt
function system_report() {
    {
        echo "CPU Usage:"
        top -b -n 1

        echo -e "/nMemory Usage:"

        free -h
        vmstat

        echo "/nDisk Usage:"
        du -h >>file
    } >$file
}
system_report
