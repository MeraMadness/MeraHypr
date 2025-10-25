#!/bin/bash

# Configuration
ROFI_THEME="spotlight-gowall"
WALLPAPER_START_DIR="$HOME/Pictures/Wallpapers/DarkWallpapers/"

# Helper: Shows a blocking message box and waits for user dismissal (Enter/Esc)
display_output() {
    local title="$1"
    local message="$2"
    echo "$message" | rofi -dmenu -e -p "$title" -theme "$ROFI_THEME" -width 600 -lines 15
}

# Helper: Uses Rofi to select an image file
get_input_file() {
    local start_dir="$WALLPAPER_START_DIR"
    local input_file

    input_file=$(find "$start_dir" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) 2>/dev/null | \
        rofi -i -dmenu -p "Select Wallpaper" -theme "$ROFI_THEME")

    echo "$input_file"
}

# Helper: Generates a unique output filename based on the action
get_output_filename() {
    local input_path="$1"
    local action_name="$2"
    local dir
    local filename
    local base_name
    local extension
    local suffix

    dir=$(dirname "$input_path")
    filename=$(basename "$input_path")
    
    if [[ "$filename" == *.* ]]; then
        base_name="${filename%.*}"
        extension="${filename##*.}"
    else
        base_name="$filename"
        extension="png" # Default extension if none found
    fi

    case "$action_name" in
        "Convert (Recolor)") suffix="_converted";;
        "Pixelate") suffix="_pixelated";;
        "Background Remove") suffix="_nobg";;
        "Invert Colors") suffix="_inverted";;
        "Draw (Borders/Grids)") suffix="_drawn";;
        "Mirror/Flip") suffix="_mirrored";;
        "Brightness") suffix="_brightened";;
        "Grayscale") suffix="_grayscale";;
        "AI Upscaling") suffix="_upscaled";;
        *) suffix="_processed";;
    esac

    echo "$dir/$base_name$suffix.$extension"
}

MENU_OPTIONS="
🎨 Convert (Recolor):Recolor an image to match a theme (e.g., Catppuccin)
🌈 Extract (Color Palette):Extract the dominant color palette (like pywal)
🧱 Pixelate:Transform the image into pixel art
✂️ Background Remove:Attempt to remove the image background
🔄 Invert Colors:Invert all colors in the image
📐 Draw (Borders/Grids):Draw a border or grid on the image
⬇️ Get Daily Wallpaper:Fetch the community-voted wallpaper of the day (-w flag)
📜 List Themes:Show all available themes for the 'convert' command
---
↔️ Mirror/Flip:Apply horizontal mirror or vertical flip
💡 Brightness:Adjust image brightness
🔳 Grayscale:Convert the image to grayscale
✨ AI Upscaling:Increase image resolution using AI models
"

while true; do
    CHOICE=$(echo -e "$MENU_OPTIONS" | rofi -i -dmenu -markup-rows -p "Gowall Commands" -theme "$ROFI_THEME" -format s)

    if [ -z "$CHOICE" ]; then
        break
    fi

    ACTION=$(echo "$CHOICE" | awk -F':' '{print $1}' | sed 's/^[[:space:]]*[^[:space:]]*[[:space:]]*//')

    case "$ACTION" in

        "Convert (Recolor)")
            INPUT_FILE=$(get_input_file)
            if [ -z "$INPUT_FILE" ]; then continue; fi

            OUTPUT_FILE=$(get_output_filename "$INPUT_FILE" "$ACTION")
            THEME=$(gowall list | rofi -i -dmenu -p "Select Theme" -theme "$ROFI_THEME" -format s)

            if [ -n "$THEME" ]; then
                gowall convert "$INPUT_FILE" -t "$THEME" --output "$OUTPUT_FILE"
                display_output "Conversion Complete" "Image converted and saved to: $OUTPUT_FILE"
            fi
            ;;

        "Extract (Color Palette)")
            INPUT_FILE=$(get_input_file)
            if [ -z "$INPUT_FILE" ]; then continue; fi

            # Define output directory for palettes and ensure it exists
            PALETTE_DIR="$HOME/Documents/Gowall_Palettes"
            mkdir -p "$PALETTE_DIR"

            FILENAME=$(basename "$INPUT_FILE")
            BASE_NAME="${FILENAME%.*}"
            OUTPUT_TXT_FILE="$PALETTE_DIR/${BASE_NAME}_palette.txt"

            PALETTE_OUTPUT=$(gowall extract "$INPUT_FILE" 2>&1)
            
            echo "$PALETTE_OUTPUT" > "$OUTPUT_TXT_FILE"

            # Reinstated text editor viewer logic:
            display_output "Color Palette Saved" "Palette extracted and saved to:\n\n$OUTPUT_TXT_FILE"
            kitty -e nvim "$OUTPUT_TXT_FILE" &
            display_output "Palette Viewer Running" "Palette file viewer is running. Close the viewer and press ESC/Enter here to return to menu."
            ;;

        "Pixelate")
            INPUT_FILE=$(get_input_file)
            if [ -z "$INPUT_FILE" ]; then continue; fi
            
            OUTPUT_FILE=$(get_output_filename "$INPUT_FILE" "$ACTION")

            SCALE=$(echo -e "5\n10\n15\n25" | rofi -i -dmenu -p "Pixel Scale (1-100)" -theme "$ROFI_THEME")

            if [ -n "$SCALE" ]; then
                gowall pixelate "$INPUT_FILE" -s "$SCALE" --output "$OUTPUT_FILE"
                display_output "Pixelation Complete" "Image pixelated and saved to: $OUTPUT_FILE"
            fi
            ;;

        "Background Remove")
            INPUT_FILE=$(get_input_file)
            if [ -z "$INPUT_FILE" ]; then continue; fi

            OUTPUT_FILE=$(get_output_filename "$INPUT_FILE" "$ACTION")
            gowall bg "$INPUT_FILE" --output "$OUTPUT_FILE"
            display_output "Background Removal Complete" "Background removed and image saved to: $OUTPUT_FILE"
            ;;

        "Invert Colors")
            INPUT_FILE=$(get_input_file)
            if [ -z "$INPUT_FILE" ]; then continue; fi

            OUTPUT_FILE=$(get_output_filename "$INPUT_FILE" "$ACTION")
            gowall invert "$INPUT_FILE" --output "$OUTPUT_FILE"
            display_output "Inversion Complete" "Colors inverted and image saved to: $OUTPUT_FILE"
            ;;

        "Draw (Borders/Grids)")
            INPUT_FILE=$(get_input_file)
            if [ -z "$INPUT_FILE" ]; then continue; fi

            OUTPUT_FILE=$(get_output_filename "$INPUT_FILE" "$ACTION")

            DRAW_TYPE=$(echo -e "border\ngrid" | rofi -i -dmenu -p "Draw Type" -theme "$ROFI_THEME")
            if [ -z "$DRAW_TYPE" ]; then continue; fi

            if [ "$DRAW_TYPE" == "border" ]; then
                SIZE_PROMPT="Thickness (px)"
                SIZE_FLAG="-t"
                SIZE_VALUES="5\n10\n20\n50"
            else
                SIZE_PROMPT="Segment Size (px)"
                SIZE_FLAG="-s"
                SIZE_VALUES="50\n80\n100\n200"
            fi

            SIZE_VALUE=$(echo -e "$SIZE_VALUES" | rofi -i -dmenu -p "$SIZE_PROMEcho "Draw Type"PT" -theme "$ROFI_THEME")
            if [ -z "$SIZE_VALUE" ]; then continue; fi
            
            COLOR="#FF00FF"
            
            gowall draw "$DRAW_TYPE" "$INPUT_FILE" -c "$COLOR" "$SIZE_FLAG" "$SIZE_VALUE" --output "$OUTPUT_FILE"
            display_output "Draw Complete" "Image drawn ($DRAW_TYPE) and saved to: $OUTPUT_FILE"
            ;;

        "Get Daily Wallpaper")
            display_output "Gowall Daily" "Downloading daily wallpaper... (Auto-saving to gowall's default location)"
            
            yes | gowall -w
            
            display_output "Daily Wallpaper Downloaded" "Daily wallpaper successfully downloaded and saved to the default gowall location.\n\nPress ESC or Enter to return to menu."
            ;;

        "List Themes")
            THEMES=$(gowall list 2>&1)
            display_output "Available Themes" "$THEMES"
            ;;
            
        "Mirror/Flip")
            INPUT_FILE=$(get_input_file)
            if [ -z "$INPUT_FILE" ]; then continue; fi
            OUTPUT_FILE=$(get_output_filename "$INPUT_FILE" "$ACTION")
            
            MIRROR_FLIP_TYPE=$(echo -e "mirror\nflip" | rofi -i -dmenu -p "Select Mirror (Horizontal) or Flip (Vertical)" -theme "$ROFI_THEME")
            if [ -z "$MIRROR_FLIP_TYPE" ]; then continue; fi
            
            gowall effects "$MIRROR_FLIP_TYPE" "$INPUT_FILE" --output "$OUTPUT_FILE"
            display_output "Effect Complete" "Image $MIRROR_FLIP_TYPE and saved to: $OUTPUT_FILE"
            ;;

        "Brightness")
            INPUT_FILE=$(get_input_file)
            if [ -z "$INPUT_FILE" ]; then continue; fi
            OUTPUT_FILE=$(get_output_filename "$INPUT_FILE" "$ACTION")

            FACTOR=$(echo "1.2" | rofi -i -dmenu -p "Brightness Factor (e.g., 1.5 brighter, 0.5 darker)" -theme "$ROFI_THEME" -lines 0)
            if [ -z "$FACTOR" ]; then continue; fi

            gowall effects br "$INPUT_FILE" -f "$FACTOR" --output "$OUTPUT_FILE"
            display_output "Effect Complete" "Brightness adjusted and image saved to: $OUTPUT_FILE"
            ;;

        "Grayscale")
            INPUT_FILE=$(get_input_file)
            if [ -z "$INPUT_FILE" ]; then continue; fi
            OUTPUT_FILE=$(get_output_filename "$INPUT_FILE" "$ACTION")

            gowall effects grayscale "$INPUT_FILE" --output "$OUTPUT_FILE"
            display_output "Effect Complete" "Grayscale conversion complete and image saved to: $OUTPUT_FILE"
            ;;
            
        "AI Upscaling")
            INPUT_FILE=$(get_input_file)
            if [ -z "$INPUT_FILE" ]; then continue; fi
            OUTPUT_FILE=$(get_output_filename "$INPUT_FILE" "$ACTION")

            SCALE=$(echo -e "2x\n4x" | rofi -i -dmenu -p "Select Scale Factor" -theme "$ROFI_THEME")
            if [ -z "$SCALE" ]; then continue; fi
            
            MODEL_MAP="realesr-animevideov3:Anime (Fast, Default)\nrealesrgan-x4plus:Generic (Slower, High Quality)\nrealesrgan-x4plus-anime:Anime (x4 Plus)"
            
            MODEL_CHOICE=$(echo -e "$MODEL_MAP" | rofi -i -dmenu -p "Select Upscale Model" -theme "$ROFI_THEME")
            if [ -z "$MODEL_CHOICE" ]; then continue; fi
            
            # Extract the command-line model name (before the colon)
            MODEL=$(echo "$MODEL_CHOICE" | awk -F':' '{print $1}')
            
            # Extract just the number from the scale (e.g., 4 from 4x)
            SCALE_NUM=${SCALE//x/}
            
            gowall upscale "$INPUT_FILE" -s "$SCALE_NUM" -m "$MODEL" --output "$OUTPUT_FILE"
            display_output "Upscaling Complete" "Image upscaled to $SCALE and saved to: $OUTPUT_FILE"
            ;;

        *)
            display_output "Error" "Unknown action selected: $ACTION"
            ;;
    esac
done

