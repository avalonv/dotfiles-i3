#!/usr/bin/env bash
# if using ipc add `polybar-msg hook marks 2` to every binding that affects
# marks (add/remove/toggle) in your i3 config (preferably as an alias).
# `set $updatemarks exec --no-startup-id polybar-msg hook marks 2`
# otherwise just run it at a regular interval

#ignore="$@"
ignore='_last S1 S2 S3'
marks=$(i3-msg -t get_marks | jq '.[]' | sort | tr --delete '"')

if [[ -n "$ignore" ]]; then
    for i in $ignore; do
        marks=$(echo "$marks" | sed "s/$i//g")
    done
fi

if [[ -n "$marks" ]]; then
    echo "$marks" | tr '\n' ' '
else
    echo ""
fi
