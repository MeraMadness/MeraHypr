#!/bin/bash

# Function to set the GTK theme
set_gtk_theme() {
    theme=$1
    gsettings set org.gnome.desktop.interface gtk-theme "$theme"
}

# Function to set the icon theme
set_icon_theme() {
    theme=$1
    gsettings set org.gnome.desktop.interface icon-theme "$theme"
}

# Paths to your light and dark GTK themes
GTK_LIGHT_THEME="Materia-light"
GTK_DARK_THEME="Materia-dark"

# Paths to your light and dark icon themes
ICON_LIGHT_THEME="Tela-circle-light"
ICON_DARK_THEME="Tela-circle-black-dark"


case $1 in
    # Load wallpaper from .cache of last session 
    "init")
        if [ -f ~/.cache/current_wallpaper.jpg ]; then
            wal -q -i ~/.cache/current_wallpaper.jpg
        else
            wal -q -i ~/Pictures/Wallpapers/
        fi
    ;;

   # Select wallpaper with rofi
    "select")
        selected=$(ls -1 ~/Pictures/Wallpapers/LightWallpapers/ ~/Pictures/Wallpapers/DarkWallpapers/ | rofi -dmenu -replace -config ~/.config/rofi/config-wallpaper.rasi)
        if [ ! "$selected" ]; then
            echo "No wallpaper selected"
            exit
        fi
        if [[ -f ~/Pictures/Wallpapers/LightWallpapers/$selected ]]; then
            wallpaper=~/Pictures/Wallpapers/LightWallpapers/$selected
            theme="light"
            wal -l -q -i "$wallpaper" # Use the -l flag for light wallpapers
        elif [[ -f ~/Pictures/Wallpapers/DarkWallpapers/$selected ]]; then
            wallpaper=~/Pictures/Wallpapers/DarkWallpapers/$selected
            theme="dark"
            wal -q -i "$wallpaper" 
        else
            echo "Wallpaper not found"
            exit
        fi
    ;;

    # Randomly select wallpaper 
    *)
        if [ $((RANDOM % 2)) -eq 0 ]; then
            wallpaper=$(ls ~/Pictures/Wallpapers/LightWallpapers/ | shuf -n 1)
            wallpaper=~/Pictures/Wallpapers/LightWallpapers/$wallpaper
            theme="light"
            wal -l -q -i "$wallpaper" 
        else
            wallpaper=$(ls ~/Pictures/Wallpapers/DarkWallpapers/ | shuf -n 1)
            wallpaper=~/Pictures/Wallpapers/DarkWallpapers/$wallpaper
            theme="dark"
            wal -q -i "$wallpaper" 
        fi
    ;;
esac

# ----------------------------------------------------- 
# Load current pywal color scheme
# ----------------------------------------------------- 
source "$HOME/.cache/wal/colors.sh"
echo "Wallpaper: $wallpaper"

# ----------------------------------------------------- 
# Copy selected wallpaper into .cache folder
# ----------------------------------------------------- 
cp "$wallpaper" ~/.cache/current_wallpaper.jpg

# ----------------------------------------------------- 
# Set the new wallpaper
# -----------------------------------------------------
# transition_type="wipe"
transition_type="outer"
# transition_type="random"

swww img "$wallpaper" \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps=60 \
    --transition-type=$transition_type \
    --transition-duration=2.5 \
    --transition-pos "$( hyprctl cursorpos )"

# ----------------------------------------------------- 
# Set GTK theme based on selected wallpaper
# -----------------------------------------------------
if [[ "$theme" == "light" ]]; then
    set_gtk_theme "$GTK_LIGHT_THEME"
    set_icon_theme "$ICON_LIGHT_THEME"
    echo "Set theme to light"
else
    set_gtk_theme "$GTK_DARK_THEME"
    set_icon_theme "$ICON_DARK_THEME"
    echo "Set theme to dark"
fi

# ----------------------------------------------------- 
# Reload waybar with new colors
# -----------------------------------------------------
~/.config/waybar/launch.sh

# -----------------------------------------------------
# Reload Swaync with new colors
# -----------------------------------------------------
~/.config/swaync/reload-swaync.sh

# ----------------------------------------------------- 
# Notify user
# -----------------------------------------------------
notify-send "Changing Color Scheme and Wallpaper"

sleep 0.5
pywalfox update
waybar
