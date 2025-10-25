#!/usr/bin/env bash
# Definisci il percorso allo script del menu principale
SCRIPTS_DIR="$HOME/.config/hypr/scripts/"
MAIN_MENU_SCRIPT="$SCRIPTS_DIR/rofi-main-menu-center.sh"

PACKAGE_NAME=$(echo "" | rofi -dmenu -p -theme spotlight-rofi-menu-center.rasi "Paru Install (AUR/Repo):")

if [[ -z "$PACKAGE_NAME" ]]; then
    exec "$MAIN_MENU_SCRIPT"
else
    # Esegue paru -S in kitty.
    kitty sh -c "paru -S \"$PACKAGE_NAME\""
fi
