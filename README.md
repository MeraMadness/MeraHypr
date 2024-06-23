# MeraHypr - My Simple Hyprland Config

I'm using this on Arch Linux but it will work on every distro, if you install every dependencies.

You can use Paru or Yay, it doesn't matter.

- **Window Manager** • [Hyprland](https://wiki.hyprland.org/) 
- **Shell** • [ZSH](https://wiki.archlinux.org/title/Zsh) - [OhMyZsh](https://ohmyz.sh/)
- **Terminal** • [Kitty](https://sw.kovidgoyal.net/kitty/#)
- **Bar** • [Waybar](https://github.com/Alexays/Waybar)
- **Notify Daemon** • [SwayNC](https://github.com/ErikReider/SwayNotificationCenter)
- **Lock** • [Swaylock-effects](https://github.com/mortie/swaylock-effects)
- **Idle** • [SwayIdle](https://github.com/swaywm/swayidle)
- **Apps Launcher** • [Rofi](https://github.com/lbonn/rofi)
- **Wallpaper Selector** • [SWWW](https://github.com/LGFae/swww)
- **File Manager** • [Thunar](https://wiki.archlinux.org/title/Thunar)
- **Login Manager** • [SDDM](https://wiki.archlinux.org/title/SDDM)
- **LoginCTL** • [Wlogout](https://github.com/ArtsyMacaw/wlogout)
- **Wayland Clipboard** • [cliphist](https://github.com/sentriz/cliphist)
- **Screenshot Utility** • [grim](https://github.com/emersion/grim) - [slurp](https://github.com/emersion/slurp)
- **Fetch** • [Fastfetch](https://github.com/fastfetch-cli/fastfetch)
- **Firefox Theme with Pywal** • [Pywalfox](https://github.com/Frewacom/pywalfox)

## ⛧ Images

<img align="center" src="/img/layout.webp">

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
paru -S hyprland waybar swaync nwg-look-bin wlogout kitty ### Basic Stuff to get Hyprland working.
```

</details>

<details>
<summary><h3>Dependencies</h3></summary>

```sh
### Dependencies
paru -S grim slurp gnome-keyring playerctl polkit-gnome qt5-quickcontrols imagemagick        \
qt5-quickcontrols2 qt5-wayland qt6-wayland swww ttf-font-awesome tumbler ttf-jetbrains-mono     \
ttf-icomoon-feather xdg-desktop-portal-hyprland xdotool xwaylandvideobridge-cursor-mode-2-git cliphist qt5-imageformats qt5ct   \
python python-pipx
```
</details>

<details>
<summary><h3>Apps & More</h3></summary>

```sh
## CLI & Tools
paru -S btop cava fastfetch rofi-wayland zsh ocs-url nvim
```

```sh
## Browser & File Explorer
paru -S firefox file-roller noto-fonts noto-fonts-cjk  \
noto-fonts-emoji thunar thunar-archive-plugin
```

```sh
# VSCode
paru -S visual-studio-code-bin
```

```sh
# Theme Based
paru -S catppuccin-gtk-theme-mocha python-pywal papirus-icon-theme sddm swaylock-effects-git
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
```

</details>

</div>

## How to Change the Wallpaper

**CTRL + Super + W** - You can Select the Wallpaper.

**Super + Shift + W** - it will choose it randomly.

**if you are using Pywal, the Wallpaper is going to change the color scheme and everything.**

## Credits

_UnixPorn: [r/unixporn](https://www.reddit.com/r/unixporn/)_

_LINUXMOBILE old Rice: [LinuxMobile](https://github.com/linuxmobile/hyprland-dots/)_

_Artist who make Wallpapers, music and more_

_Programmer and mantainers of all the opensource tools :p_

