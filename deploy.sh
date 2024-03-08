#!/bin/sh

script_dir="$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"

# $1=filename
# $2=destination
deploy_symlink() {
    origin="$script_dir/$1"
    deploy="$HOME/$2/$1"

    echo "[LOG] creating parent directory for $1"
    # mkdir -p $( dirname $deploy )
}

# $1=manifest
manifest() {
    line=0
    for row in $( cat "$script_dir/$1"); do

        # parse manifest file
        filename=$( echo $row | cut -d \: -f 1 )
        operation=$( echo $row | cut -d \: -f 2 )
        destination=$( echo $row | cut -d \: -f 3 )

        case $operation in 
            symlink)
                deploy_symlink $filename $destination
                ;;
            *)
                echo "[WARNING] unknown operation \"$operation\" in $1 manifest:$line"
                echo "[LOG] $( if $BASH_VERSIONecho -e '\u21B3' ) skipping $filename"
                ;;
        esac
        line=${line+1}
    done
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo $script_dir
    manifest linux
fi
