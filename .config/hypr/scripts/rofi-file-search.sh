#!/bin/bash

selection=$(
    fd . --hidden --type file "$HOME" 2>/dev/null | \
        sed "s;$HOME;~;" | \
        rofi -sort -sorting-method fzf -disable-history -dmenu -theme spotlight.rasi -no-custom -p "" | \
        sed "s;~;$HOME;"
)

if [ -n "$selection" ]; then
    xdg-open "$selection" &
fi
