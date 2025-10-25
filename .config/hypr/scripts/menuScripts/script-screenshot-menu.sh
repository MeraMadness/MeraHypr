#!/usr/bin/env bash
DIR_IMG="$HOME/Pictures/Screenshots"
FILENAME="$(date +%Y-%m-%d_%H-%M-%S).png"
FILE_PATH="$DIR_IMG/$FILENAME"

SCRIPTS_DIR="$HOME/.config/hypr/scripts/"
MAIN_MENU_SCRIPT="$SCRIPTS_DIR/rofi-main-menu-center.sh"
# *****************************************************************

mkdir -p "$DIR_IMG"

CHOICE=$(printf "↩️ Back\n🖼️ Full Screen\n⭐ Selected Window (Active)\n🔍 Select Any Window\n🖱️ Select Monitor\n✂️ Selected Area" | rofi -dmenu -p "📸 Cattura Schermo:" -theme spotlight-screenshot.rasi)

case "$CHOICE" in
    "↩️ Back")
        exec "$MAIN_MENU_SCRIPT"
        ;;
    "🖼️ Full Screen")
        grim "$FILE_PATH"
        notify-send "Screenshot" "Desktop Completo salvato in: $FILE_PATH"
        ;;
    "⭐ Selected Window (Active)")
        grimblast save active "$FILE_PATH"
        notify-send "Screenshot" "Finestra Attiva salvata in: $FILE_PATH"
        ;;
    "🔍 Select Any Window")
        grimblast save area "$FILE_PATH"
        notify-send "Screenshot" "Finestra Selezionata salvata in: $FILE_PATH"
        ;;
    "🖱️ Select Monitor")
        grim -g "$(slurp -o)" "$FILE_PATH"
        notify-send "Screenshot" "Monitor Selezionato salvato in: $FILE_PATH"
        ;;
    "✂️ Selected Area")
        grim -g "$(slurp)" "$FILE_PATH"
        notify-send "Screenshot" "Area Selezionata salvata in: $FILE_PATH"
        ;;
esac
