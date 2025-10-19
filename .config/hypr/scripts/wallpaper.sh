#!/bin/bash

# ------------------ CONFIG OCCULTA (Solo Dark) ------------------
GTK_THEME="catppuccin-mocha-mauve-standard+default"
ICON_THEME="Tela-circle-purple-dark"

# Definiamo SOLO la directory per gli sfondi scuri (consigliato per coerenza)
DARK_DIR=~/Pictures/Wallpapers/DarkWallpapers
ALL_DIR="$DARK_DIR" 
DEFAULT_DIR="$ALL_DIR"
# ------------------ END CONFIG ----------------------------------

# Assicurati che la directory scura esista
mkdir -p "$DARK_DIR"
# Rimuovi i symlink e ripristina la sola directory DARK_DIR per la variabile ALL_DIR
# Questo previene la logica light/dark non necessaria
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

    # Silenzia l'output di errore (2>) di wal (wal -q) per rimuovere i warning di 'convert'
    # > /dev/null redirige l'output di errore in un buco nero
    wal -q -i "$real_path" 2> /dev/null

    cp "$real_path" ~/.cache/current_wallpaper.jpg
    source "$HOME/.cache/wal/colors.sh"

    # Animazione più lenta e drammatica
    swww img "$real_path" \
        --transition-type grow \
        --transition-pos "$(hyprctl cursorpos)" \
        --transition-duration 3.0 \
        --transition-fps 60 \
        --transition-bezier 0.6,0.05,0.4,0.95

    # Applica i temi GTK e Icone scuri
    set_gtk_theme "$GTK_THEME"
    set_icon_theme "$ICON_THEME"

    # Ricarica tutti i componenti
    ~/.config/waybar/launch.sh 
    ~/.config/swaync/reload-swaync.sh
    notify-send "Rituale d'Apertura Completato" "Il tema e lo sfondo sono stati caricati."
    sleep 0.5
    pywalfox update
}


# ------------------- MAIN --------------------

case "$1" in
    "apply")
        # In questo caso $2 contiene il percorso, quindi lo passiamo come $1 alla funzione
        if [ -f "$2" ]; then
            apply_wallpaper "$2"
        else
            notify-send "Errore" "Sfondo non trovato: $2"
        fi
        ;;

    "init")
        if [ -f ~/.cache/current_wallpaper.jpg ]; then
            wal -q -R
        else
            wal -q -i "$DEFAULT_DIR"
        fi
        
        # Ricarichiamo i componenti all'inizializzazione
        ~/.config/waybar/launch.sh 
        ~/.config/swaync/reload-swaync.sh
        ;;

    "select")
        # Visualizza solo gli sfondi dalla directory scura
        dark_list=$(ls "$DARK_DIR")
        selected=$(printf "%s\n" "$dark_list" | rofi -dmenu -p "Scegli l'Altare:" -config ~/.config/rofi/config-wallpaper.rasi)

        if [ -n "$selected" ]; then
            file="${selected#\[Dark\] }" 
            apply_wallpaper "$DARK_DIR/$file" # Qui passiamo solo $1 (il percorso)
        else
            echo "Nessun altare selezionato."
            exit
        fi
        ;;

    "browse")
        # Forziamo il browser Rofi a partire dalla directory scura
        PREVIEW=true \
        rofi -no-config -theme ~/.config/rofi/wallpaper.rasi \
             -show filebrowser \
             -filebrowser-command "$0 apply" \
             -filebrowser-directory "$ALL_DIR" \
             -filebrowser-sorting-method mtime \
             -selected-row 1
        ;;

    *)
        # Random: estrae un wallpaper casuale dalla directory scura
        file=$(ls "$DARK_DIR" | shuf -n 1)
        apply_wallpaper "$DARK_DIR/$file" # Qui passiamo solo $1 (il percorso)
        ;;
esac

