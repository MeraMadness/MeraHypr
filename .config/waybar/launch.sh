#!/bin/bash

# Uccide tutte le istanze esistenti di Waybar
killall -q waybar

# Attende brevemente che il processo precedente termini
while pgrep -x waybar >/dev/null; do sleep 0.1; done

# Lancia Waybar in background. 
waybar -c ~/.config/waybar/config &
