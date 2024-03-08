#!/bin/bash

script_dir="$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"

deploy_symlink() {

    filename=$1
    destination=$2

    origin="$script_dir/$filename"
    deploy="$HOME/$destination/$filename" # todo: eliminate //

    if [[ ! -e "$origin" ]]; then
        echo "[ERROR] $origin does not exist and will result in a broken pipe" && exit 1
    fi

    mkdir -p $( dirname $deploy )

    if [[ -L "$deploy" ]]; then
        echo "[LOG] symbolic link $deploy exists, skipping"
    else
        if [[ -e "$deploy" ]]; then
            echo "[ERROR] $deploy exists but not a symbolic link" && exit 1
        else
            ln -s "$origin" "$deploy"
            echo "[OK] $origin -> $deploy"
        fi
    fi
}

manifest() {

    manifest="$1"

    if [[ ! -e "manifest/$manifest" ]]; then
        echo "[ERROR] manifest called $manifest does not exist" && exit 1
    fi

    line=0
    for row in $( cat "$script_dir/manifest/$manifest" ); do

        # parse manifest file
        filename=$( echo $row | cut -d \: -f 1 )
        operation=$( echo $row | cut -d \: -f 2 )
        destination=$( echo $row | cut -d \: -f 3 )

        case $operation in 
            symlink)
                deploy_symlink $filename $destination
                ;;
            *)
                echo "[WARNING] $manifest:$line unknown operation \"$operation\" \
skipping $filename"
                ;;
        esac
        line=${line+1}
    done
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    manifest linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
    manifest mac
fi
