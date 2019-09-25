#!/bin/bash

up='tr "[a-z]" "[A-Z]"'
down='tr "[A-Z]" "[a-z]"'
change="$down"

change_case() {
        target=$(echo "$1" | $change)
        if collision_check "$target"; then
                mv "$1" "$target" 
        fi
}

collision_check(){
        target="$1"

        if [ -e "$target" ]; then
        echo destination file \""$target"\" exists >&2
                return 1
        fi
        return 0
}

is_origin_case_only() {
        if [ -z "$opt" ]; then
                case=$(echo "$1" | $up)
        else
                case=$(echo "$1" | $down)
        fi

    if [ "$case" = "$1" ]; then
                return 0
    else
                return 1
    fi
}


process_folder() {
        orig=$(pwd)
        cd "$1"
        recursion
        cd "$orig"
}

recursion() {
        for file in *; do
                if [ -d "$file" ]; then
                        process_folder "$file"
                fi

                if [ -f "$file" ]; then
                        is_origin_case_only "$file" && change_case "$file"
                fi

        done
}

while [ $# -gt 0 ]; do
    case $1 in
    -r ) change="$up" ; opt=$1; shift;;
    * ) process_folder "$1"; was_path="True"; shift;;
    esac
done

if [ -z "$was_path" ]; then
        recursion
fi
