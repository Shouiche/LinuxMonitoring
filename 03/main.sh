#!/bin/bash
. ./validate.sh
. ./cleaner.sh

valid $1
if [ $? -eq 0 ]; then
    if [ $1 -eq 1 ]; then
        clean_by_log
    elif [ $1 -eq 2 ]; then
        clean_by_time
    elif [ $1 -eq 3 ]; then
        clean_by_mask
    fi
fi
