#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/.config/hypr/scripts/"
MAIN_MENU_SCRIPT="$SCRIPTS_DIR/rofi-main-menu-center.sh"

BACK_OPTION="↩️ Back"
SEARCH_PROMPT=" File Search:"

selection_output=$(
    printf "%s\n" "$BACK_OPTION" 
    
    (
        fd . --type file --max-depth 6 "$HOME/Pictures" "$HOME/Videos" "$HOME/Music" "$HOME/Documents" "$HOME/Downloads"
        
        fd . --type file --max-depth 3 "$HOME/.config" "$HOME/.local"
        
    ) 2>/dev/null | \
        sed "s;$HOME;~;" 
)

selection=$(
    echo -e "$selection_output" | \
    
    rofi -sort -sorting-method fzf -disable-history -dmenu -theme spotlight.rasi -no-custom -p "$SEARCH_PROMPT" | \
    sed "s;~;$HOME;"
)


if [ -z "$selection" ]; then
    exec "$MAIN_MENU_SCRIPT"
elif [ "$selection" == "$BACK_OPTION" ]; then
    exec "$MAIN_MENU_SCRIPT"
else
    xdg-open "$selection" &
fi
