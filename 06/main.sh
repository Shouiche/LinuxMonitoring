#!/bin/bash
. ./goaccess_validator.sh

CONFIG="goaccess.conf"
LOG_FILES="../04/*.log"
OUTPUT_FILE="report.html"

validate_environment && {
    echo "Generating GoAccess report..."
    
    goaccess -p "$CONFIG" -f $LOG_FILES \
             --ignore-status=200 \
             --ignore-status=201 \
             -o "$OUTPUT_FILE"

    if [ $? -eq 0 ]; then
        echo "Report successfully generated: $OUTPUT_FILE"
    else
        echo "Error: Failed to generate report"
        exit 1
    fi
}
