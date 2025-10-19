# MeraHypr - My Simple Hyprland Config with Dark/Light switching.

I'm using this on Arch Linux / CachyOS but it will work on every distro, if you install every dependencies.

You can use Paru or Yay, it doesn't matter.

- **Window Manager** • [Hyprland](https://wiki.hyprland.org/) 
- **Shell** • [ZSH](https://wiki.archlinux.org/title/Zsh) - [OhMyZsh](https://ohmyz.sh/)
- **Terminal** • [Kitty](https://sw.kovidgoyal.net/kitty/#)
- **Bar** • [Waybar](https://github.com/Alexays/Waybar)
- **Notify Daemon** • [SwayNC](https://github.com/ErikReider/SwayNotificationCenter)
- **Lock** • [Hyprlock](https://wiki.hypr.land/Hypr-Ecosystem/hyprlock)
- **Idle** • [Hypridle](https://github.com/hyprwm/hypridle)
- **Apps Launcher and about everything** • [Rofi](https://github.com/lbonn/rofi)
- **Wallpaper Selector + ROFI** • [SWWW](https://github.com/LGFae/swww)
- **File Manager** • [Thunar](https://wiki.archlinux.org/title/Thunar)
- **Login Manager** • [SDDM](https://wiki.archlinux.org/title/SDDM)
- **LoginCTL** • [Wlogout](https://github.com/ArtsyMacaw/wlogout)
- **Wayland Clipboard** • [cliphist](https://github.com/sentriz/cliphist)
- **Wayland Clipboard-Manager** • [nwg-clipman](https://github.com/nwg-piotr/nwg-clipman)
  **Screenshot Utility** • [grim](https://github.com/emersion/grim) - [slurp](https://github.com/emersion/slurp)
- **Fetch** • [Fastfetch](https://github.com/fastfetch-cli/fastfetch)
- **Color Scheme Generator with Pywal** • [Pywal](https://github.com/dylanaraps/pywal)
- **Firefox Theme with Pywal** • [Pywalfox](https://github.com/Frewacom/pywalfox)

GTK Themes I recommend.

- **Materia** • [Materia-GTK](https://github.com/nana-4/materia-theme)
- **Catppuccin Mocha Mauve** • [Catppuccin](https://github.com/catppuccin/catppuccin)
- **Orchis** • [Orchis-Theme](https://github.com/vinceliuice/Orchis-theme)

Icon Packs I recommend.

- **Tela Circle** • [Tela](https://github.com/vinceliuice/Tela-circle-icon-theme)
- **Papirus** • [Papirus-Icon-Theme](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)

Visual Studio Code Theme I use.

- **Wal Theme Generator** • [Wal](https://marketplace.visualstudio.com/items?itemName=dlasagno.wal-theme)

## ⛧ Images

<img align="center" src="/img/layout1.png">
<img align="center" src="/img/layout3.png">
<img align="center" src="/img/layout2.png">

https://github.com/MeraMadness/MeraHypr/assets/137096624/5ba13992-871b-4760-8e82-0db967f0259f

### Install Steps (Not a Tutorial)

<details>

<summary><b>Disclaimer</b></summary>

## Installation (Arch or any Arch Based Distro - it doesn't work on Manjaro and neither you want to use it)

##### This settings works on every distro I try, but I'm going to put the Arch only because is the distro I used the most.

<div align="left">

<details>
<summary><h3> Hyprland + Other Stuff<h3></summary>

###### You need to make sure you have all the prerequisites. If you are use Arch, I recommend to use Paru or Yay as the AUR Helper.

- Installation using Paru on Arch

```sh
### Hyprland + Other Stuff
paru -S hyprland waybar swaync nwg-look wlogout kitty hypridle hyprlock wlogout rofi ### Basic Stuff to get Hyprland working.
```

```sh
### Hyprland - Hyprspace [Currently it doesn't work with the newer Hyprland]
hyprpm update
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm add https://github.com/KZDKM/Hyprspace
hyprpm enable Hyprspace
hyprpm enable hyprbars
hyprpm enable hyprtrails [a bit stupid but I like it]
```

```sh
### Pyprland - More Plugins for Hyprland
https://github.com/hyprland-community/pyprland

I use Scratchpads and Magnify but I still need to understand how it works, so I'm not going to explain it.
```

</details>

<details>
<summary><h3>Dependencies</h3></summary>

```sh
### Dependencies
paru -S grim slurp gnome-keyring playerctl polkit-kde-agent qt5-quickcontrols imagemagick        \
qt5-quickcontrols2 qt5-wayland qt6-wayland swww ttf-font-awesome tumbler ttf-jetbrains-mono     \
ttf-icomoon-feather xdg-desktop-portal-hyprland xdotool nwg-clipman cliphist qt5-imageformats qt5ct   \
python python-pipx
```
</details>

<details>
<summary><h3>Apps & More</h3></summary>

```sh
## CLI & Tools
paru -S btop cava fastfetch zsh ocs-url nvim
```

```sh
## Browser & File Explorer
paru -S firefox file-roller noto-fonts noto-fonts-cjk  \
noto-fonts-emoji thunar thunar-archive-plugin tumbler ffmpeg-thumbnailer \
udisks2
```

```sh
# VSCode
paru -S visual-studio-code-bin
```

```sh
# Theme Based
paru -S materia-gtk-theme python-pywal sddm 
```

```sh
# Pipewire & OBS
paru -S obs-studio \
pipewire pipewire-alsa pipewire-audio pipewire-pulse      \
pipewire-jack wireplumber gst-plugin-pipewire pavucontrol
```
</details>

<details>
<summary><h3>Dotfiles</h3></summary>

```sh
# Dotfiles
git clone https://github.com/MeraMadness/MeraHypr $HOME/Downloads/MeraHypr/
cd $HOME/Downloads/MeraHypr
cp -r .config/* $HOME/.config
cp -r .cache/* $HOME/.cache
```

</details>

</div>

## How to Change the Wallpaper, it will change the Color Scheme.

**CTRL + Super + W** - You can Select the Wallpaper.

**Super + Shift + W** - it will choose it randomly.

## Using Rofi for changing Waybar Style
**SHIFT + CTRL + Tab** - You can choose for vertical or horizontal bar

## Using Rofi as File Searching
**SUPER + C** - You can search everything on the system.

## Credits

_UnixPorn: [r/unixporn](https://www.reddit.com/r/unixporn/)_

_LINUXMOBILE old Rice: [LinuxMobile](https://github.com/linuxmobile/hyprland-dots/)_

_Artist who make Wallpapers, music and more_

_Programmer and mantainers of all the opensource tools :p_

