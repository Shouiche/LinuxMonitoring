#!/bin/bash

. ./validate_input.sh
. ./generate_names.sh
. ./create_files.sh

target_path="${1%/}/"

if validate_input "$@"; then
    create_fs_structure "$@"
else
    exit 1
fi
