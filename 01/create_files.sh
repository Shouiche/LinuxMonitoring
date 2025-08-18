#!/bin/bash

create_fs_structure() {
    target_path="${1%/}/"
    dir_count=$2
    dir_chars=$3
    file_count=$4
    file_pattern=$5
    file_size=${6%kb}

    generate_names "dirs" "$dir_count" "$dir_chars" ""
    local folders=("${generated_names[@]}")

    generate_names "files" "$file_count" "${file_pattern%.*}" "$file_pattern"
    local files=("${generated_names[@]}")

    log_file="creation_$(date +%d%m%y).log"
    echo "Created at $(date)" > "$log_file"

    for folder in "${folders[@]}"; do
        if [ $(df / --output=avail | tail -1) -lt 1048576 ]; then
            echo "Warning: Less than 1GB free, stopping" | tee -a "$log_file"
            break
        fi

        mkdir -p "$folder" && echo "$folder [$(date +%d-%m-%Y)]" >> "$log_file"

        for file in "${files[@]}"; do
            truncate -s "${file_size}K" "$folder/$file" && \
            echo "$folder/$file [$(date +%d-%m-%Y)] ${file_size}KB" >> "$log_file"
        done
    done

    echo "Structure created successfully. Log: $log_file"
}
