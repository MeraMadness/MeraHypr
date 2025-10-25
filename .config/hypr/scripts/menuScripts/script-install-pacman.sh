#!/usr/bin/env bash
# Definisci il percorso allo script del menu principale
SCRIPTS_DIR="$HOME/.config/hypr/scripts/"
MAIN_MENU_SCRIPT="$SCRIPTS_DIR/rofi-main-menu-center.sh"

PACKAGE_NAME=$(echo "" | rofi -dmenu -p -theme spotlight-rofi-menu-center.rasi "Pacman Install:")

if [[ -z "$PACKAGE_NAME" ]]; then
    exec "$MAIN_MENU_SCRIPT"
else
    # Esegue pacman -S in kitty.
    kitty sh -c "sudo pacman -S \"$PACKAGE_NAME\""
fi
