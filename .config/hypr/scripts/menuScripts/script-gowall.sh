#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/.config/hypr/scripts/menuScripts"
MAIN_MENU_SCRIPT="$HOME/.config/hypr/scripts/rofi-main-menu-center.sh" 

pkill rofi;
sleep 0.1 # 

~/.config/hypr/scripts/rofi-gowall.sh

exec "$MAIN_MENU_SCRIPT"
