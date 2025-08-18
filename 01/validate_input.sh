#!/bin/bash

validate_input() {
    if [ $# -ne 6 ]; then
        echo "Usage: $0 <path> <dir_count> <dir_chars> <file_count> <file_pattern> <size>"
        echo "Example: $0 /opt/test 4 az 5 az.az 3kb"
        return 1
    fi

    if [ ! -d "${1%/}" ]; then
        echo "Error: Target directory ${1%/} doesn't exist"
        echo "Please create it first: sudo mkdir -p ${1%/} && sudo chown $USER ${1%/}"
        return 1
    fi

    [[ $2 =~ ^[0-9]+$ ]] || { echo "Error: dir_count must be a number"; return 1; }
    [[ $3 =~ ^[a-z]{1,7}$ ]] || { echo "Error: dir_chars must be 1-7 lowercase letters"; return 1; }
    [[ $4 =~ ^[0-9]+$ ]] || { echo "Error: file_count must be a number"; return 1; }
    [[ $5 =~ ^[a-z]{1,7}\.[a-z]{1,3}$ ]] || { echo "Error: file_pattern must be like 'abc.xyz'"; return 1; }
    [[ ${6,,} =~ ^([1-9][0-9]?|100)kb$ ]] || { echo "Error: size must be 1-100kb"; return 1; }

    return 0
}
