#!/bin/sh

script_dir="$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"

deploy() {
    in_file="$script_dir/$1"
    out_file="$HOME/$2/$1"

    echo "in file: $in_file"
    echo "out file: $out_file"
}

manifest() {
    for row in $( cat "$script_dir/$1"); do
        file_name=$(echo $row | cut -d \: -f 1)
        operation=$(echo $row | cut -d \: -f 2)
        destination=$(echo $row | cut -d \: -f 3)
        echo $file_name $operation $destination
    done
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo $script_dir
    manifest linux
fi
