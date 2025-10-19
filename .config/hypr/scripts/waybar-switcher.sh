#!/bin/bash
WAYBAR_DIR="$HOME/.config/waybar"
ROFI_BIN=$(command -v rofi || true)
WAYBAR_BIN=$(command -v waybar || true)
LOG_FILE="$HOME/.cache/waybar-switcher.log"
mkdir -p "$(dirname "$LOG_FILE")"
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/$(id -u)}
export WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-wayland-1}
if [ -z "$ROFI_BIN" ] || [ -z "$WAYBAR_BIN" ]; then
  notify-send "Waybar Switcher" "Errore: rofi o waybar non trovati"
  exit 1
fi
CHOICE=$("$ROFI_BIN" -dmenu -i -p "Seleziona Waybar Config" \
    -theme ~/.config/rofi/themes/spotlight.rasi <<< $'Verticale (Lato)\nOrizzontale (Sotto)') || CHOICE=""
case "$CHOICE" in
  "Verticale (Lato)") TARGET_CONFIG="config"; TARGET_STYLE="style.css" ;;
  "Orizzontale (Sotto)") TARGET_CONFIG="config-hor"; TARGET_STYLE="style-hor.css" ;;
  *) exit 0 ;;
esac
if [[ ! -f "$WAYBAR_DIR/$TARGET_CONFIG" || ! -f "$WAYBAR_DIR/$TARGET_STYLE" ]]; then
  MSG="Errore: file mancanti ($TARGET_CONFIG / $TARGET_STYLE)"
  echo "$MSG" | tee -a "$LOG_FILE"
  notify-send "Waybar Switcher" "$MSG"
  exit 1
fi
touch "$LOG_FILE" 2>/dev/null || true
notify-send "Waybar Switcher" "Caricamento configurazione $CHOICE..."
pkill -x waybar || true
for i in {1..20}; do
  if ! pgrep -x waybar >/dev/null; then break; fi
  sleep 0.1
done
setsid "$WAYBAR_BIN" -c "$WAYBAR_DIR/$TARGET_CONFIG" -s "$WAYBAR_DIR/$TARGET_STYLE" >> "$LOG_FILE" 2>&1 &
exit 0

