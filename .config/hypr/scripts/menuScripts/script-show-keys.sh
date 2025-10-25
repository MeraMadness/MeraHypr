#!/usr/bin/env bash
# Definisci il percorso allo script del menu principale
SCRIPTS_DIR="$HOME/.config/hypr/scripts/"
MAIN_MENU_SCRIPT="$SCRIPTS_DIR/rofi-main-menu-center.sh"

# Assumiamo che il tuo file di configurazione Hyprland sia qui
KEYBIND_FILE="$HOME/.config/hypr/keybinds.conf" 

# Apri il file in nano. Quando nano (e il terminale) si chiudono, 
# la riga successiva viene eseguita.
kitty sh -c "nvim \"$KEYBIND_FILE\""

# Dopo la chiusura del terminale, rilancia il menu principale.
exec "$MAIN_MENU_SCRIPT"
