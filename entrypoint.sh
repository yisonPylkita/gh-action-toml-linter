#!/bin/bash

status_code="0"

check_file() {
    local file_path=$1
    cp "$file_path" "$file_path.original"
    ./taplo_bin/taplo format "$file_path" >/dev/null
    diff "$file_path" "$file_path.original"
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        status_code=$exit_code
        echo "::error file={$file_path},line={line},col={col}::{TOML file not formatted}"
    fi
}

check_all() {
    echo "Scanning all the TOML files at $1"

    while IFS= read -r current_file; do
        echo "Check file $current_file"
        check_file "$current_file"
    done < <(find . -name '*.toml' -type f)
}

# To avoid execution when sourcing this script for testing
[ "$0" = "${BASH_SOURCE[0]}" ] && check_all "$@"
exit $status_code
