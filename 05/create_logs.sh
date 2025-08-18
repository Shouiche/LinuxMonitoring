#!/bin/bash

generate_log() {
    local filename=$1
    local entries=$((RANDOM % 901 + 100))  # 100-1000 записей
    
    for ((i=0; i<entries; i++)); do
        ip=$(printf "%d.%d.%d.%d" $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))
        date=$(date -d "-$((RANDOM%30)) days" '+%d/%b/%Y:%H:%M:%S %z')
        method=("GET" "POST" "PUT" "DELETE" "PATCH")
        m=${method[$((RANDOM%5))]}
        
        case $m in
            "GET") path=("/" "/index.html" "/about" "/contact" "/products")
                   code=("200" "404") ;;
            "POST") path=("/login" "/api" "/submit")
                   code=("200" "201" "400" "401") ;;
            *) code=("200" "400" "403" "500") ;;
        esac
        
        p=${path[$((RANDOM%${#path[@]}))]}
        c=${code[$((RANDOM%${#code[@]}))]}
        size=$((RANDOM%5000 + 100))
        agent=("Mozilla" "Chrome" "Safari" "curl" "Postman")
        a=${agent[$((RANDOM%5))]}
        
        echo "$ip - - [$date] \"$m $p HTTP/1.1\" $c $size \"-\" \"$a\"" >> $filename
    done
    
    echo "Создан $filename с $entries записями"
}

for i in {1..5}; do
    generate_log "nginx_$i.log"
done
