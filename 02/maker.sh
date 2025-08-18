#!/bin/bash
space_left() { df / -BM --output=avail | tail -1 | tr -d M; }

make() {
    while [ $(space_left) -gt 1024 ]; do
        local dirs=($(find / -type d -writable 2>/dev/null | grep -vE '/bin|/sbin|/dev|LinuxMonitoring'))
        [ ${#dirs[@]} -eq 0 ] && break
        
        local path=${dirs[$RANDOM%${#dirs[@]}]}
        gen_names $1 $((RANDOM%100+1))
        
        for dir in "${generated_names[@]}"; do
            mkdir -p "$path/$dir" && echo "$path/$dir [$(date +%d-%m-%Y)]" >> log.log
            
            gen_names $2 $((RANDOM%1000+1))
            for file in "${generated_names[@]}"; do
                [ $(space_left) -le 1024 ] && break
                truncate -s ${3%??}M "$path/$dir/$file" && \
                echo "$path/$dir/$file [$(date +%d-%m-%Y)] ${3%??}MB" >> log.log
            done
        done
    done
}
