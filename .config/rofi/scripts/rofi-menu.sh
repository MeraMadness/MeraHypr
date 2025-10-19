#!/bin/bash

menu_options="Browser\nTerminale\nFile Manager\nEditor\nEsci"

chosen=$(echo -e "$menu_options" | rofi -dmenu -p "Menu PSP")

case "$chosen" in
    Browser)
        firefox &
        ;;
    Terminale)
        alacritty &
        ;;
    File\ Manager)
        thunar &
        ;;
    Editor)
        code &
        ;;
    Esci)
        exit 0
        ;;
    *)
        exit 1
        ;;
esac

