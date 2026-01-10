#!/usr/bin/env bash

# ***************************************************************
# VARIABILI DI PERCORSO
# ***************************************************************
SCRIPTS_DIR="$HOME/.config/hypr/scripts"
MAIN_MENU_SCRIPT="$SCRIPTS_DIR/rofi-main-menu-center.sh"
VIDEO_DIR="$HOME/Videos"
MUSIC_DIR="$HOME/Music"

# ***************************************************************
# FUNZIONI DI SUPPORTO
# ***************************************************************

# Seleziona un file video da ~/Videos usando fd e la pipe Rofi/dmenu
select_video_file() {
    # Cerca i file video comuni (.mp4, .mkv, .webm, .mov)
    fd -e mp4 -e mkv -e webm -e mov . "$VIDEO_DIR" | rofi -dmenu -i -p "Select Video File in $VIDEO_DIR:" -theme spotlight.rasi
}

# Funzione per eseguire comandi in kitty e tornare al menu
execute_and_return() {
    COMMAND="$1"
    # Esegue il comando in kitty e torna al menu principale
    kitty sh -c "$COMMAND"
    exec "$MAIN_MENU_SCRIPT"
}

# ***************************************************************
# MENU PRINCIPALE MULTIMEDIA
# ***************************************************************

CHOICE=$(printf "↩️ Back\n▶️ FFmpeg: Convert to YT/WA (MP4)\n🎮 FFmpeg: Convert for Discord (WebM)\n🎧 FFmpeg: Extract All Audio Tracks\n⬇️ yt-dlp: Download Max Quality Video\n🎵 yt-dlp: Download Max Quality Audio\n🎶 yt-dlp: Download Playlist Audio (M4A)" | rofi -dmenu -p "🎬 Multimedia Tools:" -theme spotlight-ffmpeg.rasi)

case "$CHOICE" in
    "↩️ Back")
        # Azione 1: Torna al menu principale se selezionato esplicitamente
        exec "$MAIN_MENU_SCRIPT"
        ;;

    "▶️ FFmpeg: Convert to YT/WA (MP4)")
        INPUT_PATH=$(select_video_file)
        if [[ -z "$INPUT_PATH" ]]; then
            # Torna al menu principale se l'utente annulla la selezione del file
            exec "$MAIN_MENU_SCRIPT"
        else
            INPUT_FILE=$(basename "$INPUT_PATH")
            OUTPUT_FILE="${INPUT_FILE%.*}-output_yt.mp4"
            
            COMMAND="cd \"$VIDEO_DIR\" && ffmpeg -i \"$INPUT_PATH\" -c:v libx264 -preset slow -crf 18 -pix_fmt yuv420p -movflags +faststart -c:a aac -b:a 384k \"$OUTPUT_FILE\" && echo -e 'Conversion for YT/WA complete. Output: $VIDEO_DIR/$OUTPUT_FILE'"
            execute_and_return "$COMMAND"
        fi
        ;;

    "🎮 FFmpeg: Convert for Discord (WebM)")
        INPUT_PATH=$(select_video_file)
        if [[ -z "$INPUT_PATH" ]]; then
            # Torna al menu principale se l'utente annulla la selezione del file
            exec "$MAIN_MENU_SCRIPT"
        else
            INPUT_FILE=$(basename "$INPUT_PATH")
            OUTPUT_FILE="${INPUT_FILE%.*}-output_discord.webm"
            
            COMMAND="cd \"$VIDEO_DIR\" && ffmpeg -i \"$INPUT_PATH\" -vcodec libvpx-vp9 -crf 25 -b:v 1M -maxrate 1M -bufsize 2M -vf 'scale=-1:720' -an \"$OUTPUT_FILE\" && echo -e 'Conversion for Discord complete. Output: $VIDEO_DIR/$OUTPUT_FILE'"
            execute_and_return "$COMMAND"
        fi
        ;;

    "🎧 FFmpeg: Extract All Audio Tracks")
        INPUT_PATH=$(select_video_file)
        if [[ -z "$INPUT_PATH" ]]; then
            # Torna al menu principale se l'utente annulla la selezione del file
            exec "$MAIN_MENU_SCRIPT"
        else
            BASE_NAME=$(basename "$INPUT_PATH" | sed 's/\(.*\)\..*/\1/') 
            OUTPUT_FILE="$BASE_NAME-audio_%02d.mp3"
            
            COMMAND="cd \"$MUSIC_DIR\" && ffmpeg -i \"$INPUT_PATH\" -map 0:a -q:a 0 \"$OUTPUT_FILE\" && echo -e 'Audio extraction complete. Files saved in: $MUSIC_DIR'"
            execute_and_return "$COMMAND"
        fi
        ;;
        
    "⬇️ yt-dlp: Download Max Quality Video")
        URL=$(echo "" | rofi -dmenu -p -theme spotlight-rofi-menu-center.rasi "Video URL:")
        if [[ -z "$URL" ]]; then
            # Torna al menu principale se l'utente annulla o lascia vuoto l'URL
            exec "$MAIN_MENU_SCRIPT"
        else
            COMMAND="cd \"$VIDEO_DIR\" && yt-dlp -f 'bv+ba/b' --merge-output-format mp4 \"$URL\""
            execute_and_return "$COMMAND"
        fi
        ;;

    "🎵 yt-dlp: Download Max Quality Audio")
        URL=$(echo "" | rofi -dmenu -p -theme spotlight-rofi-menu-center.rasi "Video URL:")
        if [[ -z "$URL" ]]; then
            # Torna al menu principale se l'utente annulla o lascia vuoto l'URL
            exec "$MAIN_MENU_SCRIPT"
        else
            COMMAND="cd \"$MUSIC_DIR\" && yt-dlp -x --audio-format m4a --audio-quality 0 \"$URL\""
            execute_and_return "$COMMAND"
        fi
        ;;
        
    "🎶 yt-dlp: Download Playlist Audio (M4A)")
        URL=$(echo "" | rofi -dmenu -p -theme spotlight-rofi-menu-center.rasi "Playlist URL:")
        if [[ -z "$URL" ]]; then
            # Torna al menu principale se l'utente annulla o lascia vuoto l'URL
            exec "$MAIN_MENU_SCRIPT"
        else
            # -x: Estrai solo l'audio
            # --audio-format m4a: Converte l'audio estratto nel formato m4a
            # --audio-quality 0: Specifica la massima qualità audio (VBR migliore)
            # --yes-playlist: Per essere espliciti sul download della playlist (anche se yt-dlp lo fa di default se rileva una playlist)
            COMMAND="cd \"$MUSIC_DIR\" && yt-dlp -x --audio-format m4a --audio-quality 0 --yes-playlist \"$URL\""
            execute_and_return "$COMMAND"
        fi
        ;;
esac
