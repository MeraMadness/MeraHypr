#!/usr/bin/env bash

# Percorso ai tuoi script. Assicurati che sia corretto!
SCRIPTS_DIR="$HOME/.config/hypr/scripts/menuScripts/" 

CHOICE=$(printf "🔎 Search Files\n✨ Update System\n📥 Install Package (Pacman)\n🤓 Install AUR Package (Paru)\n🗑️ Remove Package\n🧮 Calculator\n📸 Screenshot Menu\n😀 Emoji Selector\n📑 Firefox Bookmarks\n📋 Clipboard\n🎬 Multimedia Tools\n🎨 Color Picker\n🧑‍🎨 Gowall Menu\n🔑 Show Keybindings\n🛑 Power Menu" | rofi -dmenu -i -p "⚙️ System Menu:" -theme spotlight-rofi-menu.rasi)

case "$CHOICE" in
    "🔎 Search Files")
        "$SCRIPTS_DIR/rofi-file-search.sh"
        ;;
    "✨ Update System")
        "$SCRIPTS_DIR/script-update.sh"
        ;;
    "📥 Install Package (Pacman)")
        "$SCRIPTS_DIR/script-install-pacman.sh"
        ;;
    "🤓 Install AUR Package (Paru)")
        "$SCRIPTS_DIR/script-install-aur.sh"
        ;;
    "🗑️ Remove Package")
        "$SCRIPTS_DIR/script-remove-package.sh"
        ;;
    "🧮 Calculator")
        "$SCRIPTS_DIR/script-calculator.sh"
        ;;
    "📸 Screenshot Menu")
        "$SCRIPTS_DIR/script-screenshot-menu.sh"
        ;;
    "😀 Emoji Selector")
        "$SCRIPTS_DIR/script-rofi-emoji.sh"
        ;;
    "📑 Firefox Bookmarks")
        "$SCRIPTS_DIR/script-bookmarks.sh"
        ;;
    "📋 Clipboard")
        "$SCRIPTS_DIR/script-clipman.sh"
        ;;
    "🎬 Multimedia Tools")
        "$SCRIPTS_DIR/script-multimedia-menu.sh"
        ;;
    "🎨 Color Picker")
        "$SCRIPTS_DIR/script-colorpicker.sh"
        ;;
    "🧑‍🎨 Gowall Menu")
        "$SCRIPTS_DIR/script-gowall.sh"
        ;;
    "🔑 Show Keybindings")
        "$SCRIPTS_DIR/script-show-keys.sh"
        ;;
    "🛑 Power Menu")
        "$SCRIPTS_DIR/script-wlogout.sh"
        ;;
esac
