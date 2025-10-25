#!/bin/bash

GTK_THEME="adw-gtk3-dark" 
ICON_THEME="Tela-circle-purple-dark"

DARK_DIR=~/Pictures/Wallpapers/DarkWallpapers
ALL_DIR="$DARK_DIR" 
DEFAULT_DIR="$ALL_DIR"

mkdir -p "$DARK_DIR"
find -L "$ALL_DIR" -type l -delete

set_gtk_theme() {
    gsettings set org.gnome.desktop.interface gtk-theme "$1"
}

set_icon_theme() {
    gsettings set org.gnome.desktop.interface icon-theme "$1"
}

apply_wallpaper() {
    input_path="$1" 
    real_path="$(readlink -f "$input_path")"

    echo "1. Applying Pywal theme (Terminal, Waybar, Rofi)..."
    wal -q -i "$real_path" 2> /dev/null
    source "$HOME/.cache/wal/colors.sh" 
    
    echo "2. Applying Matugen Material You colors (GTK only)..."
    matugen image "$real_path" -m "dark" 
    
    cp "$real_path" ~/.cache/current_wallpaper.jpg

    swww img "$real_path" \
        --transition-type grow \
        --transition-pos "$(hyprctl cursorpos)" \
        --transition-duration 3.0 \
        --transition-fps 60 \
        --transition-bezier 0.6,0.05,0.4,0.95

    set_gtk_theme "$GTK_THEME"
    set_icon_theme "$ICON_THEME"
    echo "3. Forcing GTK theme reload..."
    gsettings set org.gnome.desktop.interface gtk-theme '' 
    set_gtk_theme "$GTK_THEME"

    ~/.config/waybar/launch.sh 
    ~/.config/swaync/reload-swaync.sh
    notify-send "Rituale d'Apertura Completato" "Il tema e lo sfondo sono stati caricati."
    sleep 0.5
    pywalfox update
}


# ------------------- MAIN --------------------

case "$1" in
    "apply")
        if [ -f "$2" ]; then
            apply_wallpaper "$2"
        else
            notify-send "Errore" "Sfondo non trovato: $2"
        fi
        ;;

    "init")
        if [ -f ~/.cache/current_wallpaper.jpg ]; then
            wal -q -R 
            matugen image ~/.cache/current_wallpaper.jpg -m "dark" 
        else
            file=$(find "$DEFAULT_DIR" -type f \( -name "*.jpg" -o -name "*.png" \) | shuf -n 1)
            wal -q -i "$file"
            matugen image "$file" -m "dark"
        fi
        
        ~/.config/waybar/launch.sh 
        ~/.config/swaync/reload-swaync.sh
        ;;
        
    "select")
        dark_list=$(ls "$DARK_DIR")
        selected=$(printf "%s\n" "$dark_list" | rofi -dmenu -p "Scegli l'Altare:" -config ~/.config/rofi/config-wallpaper.rasi)

        if [ -n "$selected" ]; then
            file="${selected#\[Dark\] }" 
            apply_wallpaper "$DARK_DIR/$file"
        else
            echo "Nessun altare selezionato."
            exit
        fi
        ;;

    "browse")
        PREVIEW=true \
        rofi -no-config -theme ~/.config/rofi/wallpaper.rasi \
             -show filebrowser \
             -filebrowser-command "$0 apply" \
             -filebrowser-directory "$ALL_DIR" \
             -filebrowser-sorting-method mtime \
             -selected-row 1
        ;;

    *)
        file=$(ls "$DARK_DIR" | shuf -n 1)
        apply_wallpaper "$DARK_DIR/$file"
        ;;
esac
