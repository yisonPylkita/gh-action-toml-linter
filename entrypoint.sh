#!/bin/bash

status_code="0"

check_file() {
    local file_path=$1
    ./taplo fmt --check "$file_path"
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        status_code=$exit_code
        echo "::error file={$file_path},line={line},col={col}::{TOML file not formatted}"
    fi
}

check_all() {
    echo "Scanning all TOML files at $(pwd)"

    while IFS= read -r current_file; do
        echo "Check file $current_file"
        check_file "$current_file"
    done < <(find . -name '*.toml' -type f)
}

download_taplo() {
    wget https://raw.githubusercontent.com/yisonPylkita/gh-action-toml-linter/main/taplo_bin/taplo
    chmod +x ./taplo
    echo "Downloaded Taplo bin"
    ls -la
}

# To avoid execution when sourcing this script for testing
[ "$0" = "${BASH_SOURCE[0]}" ] && download_taplo && check_all "$@"
exit $status_code
