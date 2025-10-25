#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/.config/hypr/scripts"
MAIN_MENU_SCRIPT="$SCRIPTS_DIR/rofi-main-menu-center.sh"

pkill rofi;
sleep 0.1 

rofi -show calc -modi calc -no-show-match -no-sort -theme spotlight.rasi

exec "$MAIN_MENU_SCRIPT"


