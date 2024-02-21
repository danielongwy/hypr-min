# Name
Minimal installation of Hyprland(Repo) + Arch Linux

# Installation
(TODO)
`sh install.sh`
For nvidia see ....

# Features
Core Packages
- Terminal: **kitty**
- File Manager: **thunar**
- Text Editor: **neovim**
- Wallpaper: **hyprpaper**
- Status Bar: **waybar**
- Notification Daemon: **dunst**
- Screenshot: **grim** + **slurp**
- Screenlocker: **swaylock-effects** (Not installed 21 02 2024 has bugs)
- Logout Handler: **wlogout** (Not installed)
- Image Viewer: **imv**
- Video Player: **mpv**
- Audio: **pipeware** && **wireplumber**
- Shell: **bash** + **starship**
- Task Manager: **btop**
- Authentication Agent: **polkit-kde-agent**


<details>
<summary>
    Supporting Packages
</summary>
 
    - git
    - yay
    - qt5-wayland
    - qt6-wayland
    - qt5ct
    - qt6ct 
    - xdg-desktop-portal-hyprland
    - xdg-desktop-portal-gtk (Reccomended for `file picker` in Hyprland Wiki)
    - bluetooth packages (? - required more testing)
    - wl-clipboard : Enable *neovim* system compatible clipboard
    - htop : Process Manager
    - xdg-user-dirs : File manager support for common directories
    - udiskie (? double check if needed for mounting)
    - nwg-look-bin
    - kvantum
    - hyprpicker-git
    - thunar-volman, gvfs | Support for mounting devices
    - thunar-archieve-plugins & xarchiver | Allows for right-click extract functions
    - tumbler | Adds preview thumbnails to thunar
</details>



# Theming

Icons
- papirus-icon-theme

Font Configurations
- noto-fonts
- noto-fonts-emoji
- noto-fonts-cjk
- ttf-jetbrains-mono-nerd
- ttf-firacode-nerd

Applications
- telegram-desktop
- obsidian

ClipBord:
TODO https://wiki.hyprland.org/Useful-Utilities/Clipboard-Managers/

Debug Tools (not needed for main install):
- -xorg-eyes 


<br/>


# Important Notes
#### Things to add to hypland.conf (? - Move section elsewhere)
```
exec-once=/usr/lib/polkit-kde-authentication-agent-1
```


<br/><br/>

# Setting Up NVIDIA with Hyprland
###### More details in the [Official Hyprland Wiki](https://wiki.hyprland.org/Nvidia/)
*Note*: `nvim` can be replace with a command-line text editor of your choice

Install required dependancies

**Step 1**

```
yay -S linux-headers nvidia-dkms qt5-wayland qt5ct libva libva-nvidia-driver-git
```
<br/>

**Step 2**

Add `nvidia_drm.modeset=1` to the end of `GRUB_CMDLINE_LINUX_DEFAULT=` in `/etc/default/grub`

```
sudo nvim /etc/default/grub
```
```
nvidia_drm.modeset=1
```

Rebuild GRUB with following command
```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```
For `systemd-boot` see [here](http://wiki.hyprland.org/Nvidia/#how-to-get-hyprland-to-possibly-work-on-nvidia).

<br/>

**Step 3**

Add to `modules` in `/etc/mkinitcpio.conf`

```
sudo nvim /etc/mkinitcpio.conf
```
```
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```

Generate a new initramfs image (Must have `linux-headers` package installed)

```
sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
```
<br/>

**Step 4**

Create a NVIDIA .conf file:
```
echo "options nvidia-drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf
```

and verify by running command below, output should be `options nvidia-drm modeset=1`
```
cat /etc/modprobe.d/nvidia.conf
```
<br/>

**Step 5**

Export these variables to *hyprland.conf*

```
env = LIBVA_DRIVER_NAME,nvidia
env = XDG_SESSION_TYPE,wayland
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = WLR_NO_HARDWARE_CURSORS,1
```


Once done reboot your system
```
systemctl reboot
```


# TODO | Future Reference/Personalisation
- [Auto-login on TTY1](https://wiki.archlinux.org/title/Getty#Automatic_login_to_virtual_console)
- Waybar (EricMurphy things maybe)
- Screenshot base on hyprland wii
- hyprland conf workspace startup (hyprland wiki has a nice script)
- Improve Hyprland Install script base on HyprV4
- Look through (https://github.com/0bCdian/Hyprland_dotfiles/tree/gruvboxy)

[comment]: <> (This is a comment, it will not be included)
[comment]: <> (in  the output file unless you use it in)
[comment]: <> (a reference style link.)
<!-- your comment -->
[//]: <> (This is also a comment.)
[//]: # (This may be the most platform independent comment)
## References:
https://github.com/astonish-g/hypr-catppuccin-dotfiles/tree/main
https://github.com/ericmurphyxyz/dotfiles

https://github.com/JohnOberhauser/Varda-Theme/tree/main/hypr/scripts/screenshots
