#! /bin/bash

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
    local first_line=$(head -n 1 "$file_path")
    echo
    echo "###############################################"
    echo "         Scanning $file"
    echo "###############################################"
    taplo format "$file_path"
    git diff --exit-code
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
        printf "%b" "Successfully scanned ${file_path} 🙌\n"
    else
        status_code=$exit_code
        printf "\e[31m ERROR: taplo detected issues in %s.\e[0m\n" "${file_path} 🐛"
    fi
}

scan_all() {
    echo "Scanning all the TOML files at $1 🔎"

    while IFS= read -r script; do
        scan_file "$script"
    done < <(find "$1" -name '*.toml' -o ! -name '*.*' -type f ! -path "$1/.git/*")
}

# To avoid execution when sourcing this script for testing
[ "$0" = "${BASH_SOURCE[0]}" ] && process_input "$@"

# find . -name "*.toml" -exec taplo format {} \;
# {  ; } || { echo "::error file={name},line={line},col={col}::{TOML lints failed}"; }
