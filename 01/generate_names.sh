#!/bin/bash

generate_names() {
    local type=$1 count=$2 chars=$3 pattern=$4
    local date=$(date +%d%m%y)
    generated_names=()

    if [ "$type" == "files" ]; then
        local name_part=${pattern%.*}
        local ext_part=${pattern#*.}
    fi

    for ((i=0; i<count; i++)); do
        local base=""
        for ((j=0; j<${#chars}; j++)); do
            base+=${chars:$j:1}$(tr -dc ${chars:$j:1} < /dev/urandom | head -c $((RANDOM%3+1)))
        done

        if [ "$type" == "files" ]; then
            generated_names+=("${base:0:7}_$date.$ext_part")
        else
            generated_names+=("${target_path}${base:0:7}_$date")
        fi
    done
}
