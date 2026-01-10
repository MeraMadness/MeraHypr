#!/bin/bash

# ==========================================================
# Script per iniettare i colori di Pywal nel CSS di nwg-dock
# Questo script gestisce la sintassi RGBA complessa.
# ==========================================================

WAL_CACHE="$HOME/.cache/wal"
INPUT_CSS="$HOME/.config/nwg-dock-hyprland/style_template.css"
OUTPUT_CSS="$HOME/.config/nwg-dock-hyprland/style.css"

if [ ! -f "$WAL_CACHE/colors.yml" ]; then
    echo "Errore: File di cache Pywal non trovato. Eseguire 'wal -i immagine' prima."
    exit 1
fi

# 1. Leggi i colori esadecimali (SENZA #)
# La sintassi con awk e sed è per estrarre il valore esadecimale dal file YML.

C4=$(grep 'colors: \|color4:' "$WAL_CACHE/colors.yml" | awk '{print $2}' | sed 's/"//g' | head -n 1)
C7=$(grep 'special: \|foreground:' "$WAL_CACHE/colors.yml" | awk '{print $2}' | sed 's/"//g' | head -n 1)
C8=$(grep 'colors: \|color8:' "$WAL_CACHE/colors.yml" | awk '{print $2}' | sed 's/"//g' | head -n 1)
C15=$(grep 'colors: \|color15:' "$WAL_CACHE/colors.yml" | awk '{print $2}' | sed 's/"//g' | head -n 1)

# 2. Esegui la sostituzione con Sed e scrivi nel file di output
# NOTA: La sostituzione viene fatta con il '#' solo dove richiesto da CSS semplice.
# Per RGBA, usiamo '0x' per convertire l'esadecimale in RGB.

sed \
    -e "s/background: color4/background: #$C4/g" \
    -e "s/color: color8/color: #$C8/g" \
    -e "s/color: color7/color: #$C7/g" \
    -e "s/rgba(color8/rgba($((0x${C8:0:2})),$((0x${C8:2:2})),$((0x${C8:4:2}))/g" \
    -e "s/rgba(color15/rgba($((0x${C15:0:2})),$((0x${C15:2:2})),$((0x${C15:4:2}))/g" \
    -e "s/background-color: rgba(color15/background-color: rgba($((0x${C15:0:2})),$((0x${C15:2:2})),$((0x${C15:4:2}))/g" \
    "$INPUT_CSS" > "$OUTPUT_CSS"

echo "CSS di nwg-dock aggiornato e salvato in $OUTPUT_CSS"

# Riavvia il dock
pkill nwg-dock-hyprland
nwg-dock-hyprland -d -nolauncher -mb 15 & disown
