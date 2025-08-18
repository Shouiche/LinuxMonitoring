#!/bin/bash
gen_names() {
    local str=$1 arr=() ext=""
    for ((i=0; i<${#str}; i++)); do
        [[ ${str:$i:1} == "." ]] && { ext=${str:$i+1}; break; }
        [[ ! " ${arr[@]} " =~ " ${str:$i:1} " ]] && arr+=(${str:$i:1})
    done
    local count=0 names=() date=$(date +%d%m%y)
    while [ $count -lt $2 ]; do
        local name=""
        for c in "${arr[@]}"; do
            name+=$c$(tr -dc $c </dev/urandom | head -c $((RANDOM%3+1)))
        done
        names+=("${name:0:7}_$date$([ -n "$ext" ] && echo .$ext)")
        ((count++))
    done
    generated_names=("${names[@]}")
}
