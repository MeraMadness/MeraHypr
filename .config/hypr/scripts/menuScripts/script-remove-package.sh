#!/usr/bin/env bash
# Definisci il percorso allo script del menu principale
SCRIPTS_DIR="$HOME/.config/hypr/scripts/"
MAIN_MENU_SCRIPT="$SCRIPTS_DIR/rofi-main-menu-center.sh"

PACKAGE_NAME=$(echo "" | rofi -dmenu -p -theme spotlight-rofi-menu-center.rasi "Package to Remove (paru -Rs):")

# Se l'utente preme ESCAPE o lascia il campo vuoto, Rofi restituisce una stringa vuota.
if [[ -z "$PACKAGE_NAME" ]]; then
    # Rilancia il menu principale se l'input è vuoto
    exec "$MAIN_MENU_SCRIPT"
else
    # Esegue paru -Rs in kitty.
    kitty sh -c "paru -Rs \"$PACKAGE_NAME\""
fi
