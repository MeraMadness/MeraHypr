case $1 in

    # Load wallpaper from .cache of last session 
    "init")
        if [ -f ~/.cache/current_wallpaper.jpg ]; then
            wal -q -i ~/.cache/current_wallpaper.jpg
        else
            wal -q -i ~/Pictures/Wallpapers//
        fi
    ;;

    # Select wallpaper with rofi
    "select")
        selected=$(ls -1 ~/Pictures/Wallpapers/ | rofi -dmenu -replace -config ~/.config/rofi/config-wallpaper.rasi)
        if [ ! "$selected" ]; then
            echo "No wallpaper selected"
            exit
        fi
        wal -q -i ~/Pictures/Wallpapers//$selected
    ;;

    # Randomly select wallpaper 
    *)
        wal -q -i ~/Pictures/Wallpapers/
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
cp $wallpaper ~/.cache/current_wallpaper.jpg

# ----------------------------------------------------- 
# Reload waybar with new colors
# -----------------------------------------------------
~/.config/waybar/launch.sh

# -----------------------------------------------------
# Reload Swaync with new colors
#
~/.config/swaync/reload-swaync.sh

# ----------------------------------------------------- 
# Set the new wallpaper
# -----------------------------------------------------
transition_type="wipe"
# transition_type="outer"
# transition_type="random"

swww img $wallpaper \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps=60 \
    --transition-type=$transition_type \
    --transition-duration=0.7 \
    --transition-pos "$( hyprctl cursorpos )"

# ----------------------------------------------------- 
# Loading the configuration
# -----------------------------------------------------
#
#

notify-send Changing Color Scheme and Wallpaper

waybar -c ~/.config/waybar/${arrThemes[0]}/config -s ~/.config/waybar/${arrThemes[1]}/style.css &
sleep 0.5
pywalfox update

