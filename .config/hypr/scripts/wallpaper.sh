#!/bin/bash

# ------------------ CONFIG ------------------
GTK_LIGHT_THEME="Materia-light"
GTK_DARK_THEME="Materia-dark"
ICON_LIGHT_THEME="Tela-circle-light"
ICON_DARK_THEME="Tela-circle-black-dark"

LIGHT_DIR=~/Immagini/Wallpapers/LightWallpapers
DARK_DIR=~/Immagini/Wallpapers/DarkWallpapers
ALL_DIR=~/Immagini/Wallpapers/AllWallpapers
DEFAULT_DIR="$ALL_DIR"
# ------------------ END CONFIG --------------

# Ensure ALL_DIR exists and includes both light and dark wallpapers
mkdir -p "$ALL_DIR"
find -L "$ALL_DIR" -type l -delete
ln -sf "$LIGHT_DIR"/* "$ALL_DIR"/
ln -sf "$DARK_DIR"/* "$ALL_DIR"/

set_gtk_theme() {
    gsettings set org.gnome.desktop.interface gtk-theme "$1"
}
set_icon_theme() {
    gsettings set org.gnome.desktop.interface icon-theme "$1"
}

apply_wallpaper() {
    input_path="$1"
    real_path="$(readlink -f "$input_path")"

    if [[ "$real_path" == "$LIGHT_DIR"* ]]; then
        theme="light"
        wal -l -q -i "$real_path"
    else
        theme="dark"
        wal -q -i "$real_path"
    fi

    cp "$real_path" ~/.cache/current_wallpaper.jpg
    source "$HOME/.cache/wal/colors.sh"

    swww img "$real_path" \
        --transition-bezier .43,1.19,1,.4 \
        --transition-fps=60 \
        --transition-type=outer \
        --transition-duration=2.5 \
        --transition-pos "$(hyprctl cursorpos)"

    if [[ "$theme" == "light" ]]; then
        set_gtk_theme "$GTK_LIGHT_THEME"
        set_icon_theme "$ICON_LIGHT_THEME"
    else
        set_gtk_theme "$GTK_DARK_THEME"
        set_icon_theme "$ICON_DARK_THEME"
    fi

    ~/.config/waybar/launch.sh
    ~/.config/swaync/reload-swaync.sh
    notify-send "Wallpaper and Theme Changed"
    sleep 0.5
    pywalfox update
    waybar
}

# ------------------- MAIN --------------------

case "$1" in
    "apply")
        if [ -f "$2" ]; then
            apply_wallpaper "$2"
        else
            notify-send "Invalid wallpaper: $2"
        fi
        ;;

    "init")
        if [ -f ~/.cache/current_wallpaper.jpg ]; then
            wal -q -R
        else
            wal -q -i "$DEFAULT_DIR"
        fi
        ;;

    "select")
        light_list=$(ls "$LIGHT_DIR" | sed 's/^/[Light] /')
        dark_list=$(ls "$DARK_DIR" | sed 's/^/[Dark] /')
        selected=$(printf "%s\n%s" "$light_list" "$dark_list" | rofi -dmenu -p "Select Wallpaper:" -config ~/.config/rofi/config-wallpaper.rasi)

        if [[ "$selected" == "[Light] "* ]]; then
            file="${selected#\[Light\] }"
            apply_wallpaper "$LIGHT_DIR/$file"
        elif [[ "$selected" == "[Dark] "* ]]; then
            file="${selected#\[Dark\] }"
            apply_wallpaper "$DARK_DIR/$file"
        else
            echo "No wallpaper selected"
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
        # Random
        if [ $((RANDOM % 2)) -eq 0 ]; then
            file=$(ls "$LIGHT_DIR" | shuf -n 1)
            apply_wallpaper "$LIGHT_DIR/$file"
        else
            file=$(ls "$DARK_DIR" | shuf -n 1)
            apply_wallpaper "$DARK_DIR/$file"
        fi
        ;;
esac

