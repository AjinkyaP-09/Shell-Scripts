#####################################################################
# Script Name : 07_SYS_REPORT_V2.sh
# Version :2.0
# Date : 22 Oct 2025
# Credit : Team CloudEthiX
# Purpose : Genenrate system resource usage and state report.
#####################################################################

#!/bin/bash
OUTPUT_FILE="$1"

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [output_file]"
    exit 1
fi

if ! touch "$OUTPUT_FILE" 2>/dev/null; then
    echo "Error: Cannot write to output file '$OUTPUT_FILE'."
    echo "Please check permissions or provide a valid path."
    exit 1
fi

echo "Generating system report... "

>"$OUTPUT_FILE"

{
    echo "========== System Report: $(date) =========="
    echo ""

    echo "CPU Usage (Top 5)"
    top -b -n 1 | head -n 12
    echo ""

    echo "Memory Usage"
    free -h
    echo ""

    echo "Virtual Memory Statistics"
    vmstat 1 2
    echo ""

    echo "Disk Usage (Overall)"
    df -hT
    echo ""

} >>"$OUTPUT_FILE"

echo "Report successfully generated: $OUTPUT_FILE"
exit 0
