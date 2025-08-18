#!/bin/bash

validate_environment() {
    
    if [ -z "$(ls ../04/*.log 2>/dev/null)" ]; then
        echo "Error: No log files found in ../04/"
        return 1
    fi

    
    if [ ! -f "goaccess.conf" ]; then
        echo "Error: Config file goaccess.conf not found"
        return 1
    fi

    return 0
}
