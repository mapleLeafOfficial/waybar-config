#!/bin/bash
set -e

active="●"
inactive="○"
workspace_str=""
monitor=$1

reading_output=0
while read -r line; do
    if [ $reading_output -eq 0 ] && [[ "$line" == *"\"$monitor\":"* ]]; then
        reading_output=1
        continue
    elif [ $reading_output -eq 1 ]; then
        if [ -z "$line" ]; then
            printf "%s\n" "${workspace_str%"  "}"
            exit
        fi

        if [[ "$line" =~ ^\* ]]; then
            workspace_str+="$active  "
        else
            workspace_str+="$inactive  "
        fi
    fi
done <<< "$(niri msg workspaces)"

printf "%s\n" "${workspace_str%"  "}"

