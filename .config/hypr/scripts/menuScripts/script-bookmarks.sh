#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/.config/hypr/scripts"
MAIN_MENU_SCRIPT="$SCRIPTS_DIR/rofi-main-menu-center.sh"


pkill rofi;
sleep 0.1 # Breve pausa per pulizia

~/.config/rofi/bookmarks/bookmarks.sh

exec "$MAIN_MENU_SCRIPT"


