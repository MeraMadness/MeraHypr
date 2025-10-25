#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/.config/hypr/scripts"
MAIN_MENU_SCRIPT="$SCRIPTS_DIR/rofi-main-menu-center.sh"

pkill rofi;
sleep 0.4 

rofi -modi emoji -show emoji -kb-secondary-copy "" -kb-custom-1 "Control+c" -theme spotlight.rasi

exec "$MAIN_MENU_SCRIPT"
