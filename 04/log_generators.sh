#!/bin/bash

get_ip() {
    printf "%d.%d.%d.%d" $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256))
}

get_status() {
    local codes=(200 400 401 403 404 500 502 503)
    [[ $1 != "GET" ]] && codes+=(501)
    [[ $1 =~ ^(POST|PUT|PATCH)$ ]] && codes+=(201)
    echo ${codes[RANDOM%${#codes[@]}]}
}

get_method() {
    local methods=(GET POST PUT PATCH DELETE)
    echo ${methods[RANDOM%${#methods[@]}]}
}

get_path() {
    local paths=(/ /status /page{1..3} /api/v1/{login,account})
    echo ${paths[RANDOM%${#paths[@]}]}
}

get_agent() {
    local agents=(
        "Mozilla/5.0" "Chrome/91.0" "Safari/537.36" "Opera/77.0" 
        "Edge/91.0" "Googlebot/2.1" "curl/7.68.0"
    )
    echo "${agents[RANDOM%${#agents[@]}]}"
}

make_log_entry() {
    local method=$(get_method)
    printf "%s - - %s \"%s %s HTTP/1.1\" %d %d \"-\" \"%s\"\n" \
        $(get_ip) "$1" "$method" $(get_path) $(get_status "$method") $((RANDOM%5000)) $(get_agent)
}
