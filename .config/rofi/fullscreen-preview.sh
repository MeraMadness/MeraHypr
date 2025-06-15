#!/bin/sh

WallDir=${1:-~/Immagini/Wallpapers/DarkWallpapers/}

PREVIEW=true \
rofi -no-config -theme ~/.config/rofi/wallpaper.rasi \
	-show filebrowser -filebrowser-command 'setbg' \
	-filebrowser-directory "$WallDir" \
	-filebrowser-sorting-method mtime \
	-selected-row 1 >/dev/null
