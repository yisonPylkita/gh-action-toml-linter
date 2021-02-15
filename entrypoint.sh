#!/bin/bash

input_paths="$1"
my_dir=$(pwd)
status_code="0"

process_input() {
    scan_all "$my_dir"
    exit $status_code
}

scan_file() {
    local file_path=$1
    local file=$(basename -- "$file_path")
    echo
    echo "###############################################"
    echo "         Scanning $file"
    echo "###############################################"
    ls -la
    sudo ./taplo format "$file_path"
    git diff --exit-code
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
        printf "%b" "Successfully scanned ${file_path} 🙌\n"
    else
        status_code=$exit_code
        printf "\e[31m ERROR: taplo detected issues in %s.\e[0m\n" "${file_path} 🐛"
    fi
    git checkout -- .
}

scan_all() {
    echo "Scanning all the TOML files at $1 🔎"

    while IFS= read -r current_file; do
        echo "Scan file $current_file"
        scan_file "$current_file"
    done < <(find "$1" -name '*.toml' -type f)
}

echo "I'm in shell script babe"
# To avoid execution when sourcing this script for testing
[ "$0" = "${BASH_SOURCE[0]}" ] && process_input "$@"

# find . -name "*.toml" -exec taplo format {} \;
# {  ; } || { echo "::error file={name},line={line},col={col}::{TOML lints failed}"; }
