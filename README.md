## Minimal installation of Hyprland(Repo) + Arch Linux


- Terminal: kitty
- File Manager: thunar
- Unix Text Editor: neovim
- Wallpaper: Hyprpaper
- Status Bar: Waybar
- Notification Daemon: Dunst
- Terminal: kitty
- Logout: wlogout 
- Image viewer: imv
- Video Player: mpv
- PDF Viewer: ?
- Color Picker: hyprpicker-git
- Screenshot : ?
- screenlocker: swaylock-effects
- Audio scripts ecrip murpy
- Audio:
    - pipeware
    - wireplumber
- Authentication Agent: polkit-kde-agent
- Misc
    - git
    - yay
- Desktop Portal: xdg-desktop-portal-hyprland
- Shell Prompt: starship + bash
- Task Manager: btop

#### Other packages:

- qt5-wayland
- qt6-wayland
- qt5ct
- qt6ct 
- xdg-desktop-portal-gtk (Reccomended for `file picker` in Hyprland Wiki)
- hasci a
- bluetooth packages (? - required more testing)
- wl-clipboard : Enable *neovim* system compatible clipboard
- htop : Process Manager
- xdg-user-dirs : File manager support for common directories
- udiskie (? double check if needed for mounting)
- nwg-look-bin
- kvantum


#### File Manager (Thunar)
- thunar
- thunar-volman, gvfs : (Support Thunar for mounting internal device)
- thunar-archieve-plugins & xarchiver (Work hand in hand)
<br/>

## Theming

#### Icons
- papirus-icon-theme


#### Font Configurations
- noto-fonts-cjk
- ttf-jetbrains-mono-nerd
- ttf-firacode-nerd

**APPS**
- telegram-desktop
- obsidian

ClipBord:
TODO https://wiki.hyprland.org/Useful-Utilities/Clipboard-Managers/

Debug Tools (not needed for main install):
- -xorg-eyes 


must_have=(
    pipewire
    wireplumber
    polkit-kde-agent
    qt5-wayland
    qt6-wayland
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
)

<br/>

#### Things to add to hypland.conf (? - Move section elsewhere)
```
exec-once=/usr/lib/polkit-kde-authentication-agent-1
```


<br/><br/>

## Setting Up NVIDIA with Hyprland
###### More details in the [Official Hyprland Wiki](https://wiki.hyprland.org/Nvidia/)
*Note*: `nvim` can be replace with a command-line text editor of your choice

Install required dependancies

```
yay -S linux-headers nvidia-dkms qt5-wayland qt5ct libva libva-nvidia-driver-git
```
<br/>

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

Add to `modules` in `/etc/mkinitcpio.conf`

```
sudo nvim /etc/mkinitcpio.conf
```
```
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```
<br/>

Generate a new initramfs image (Must have `linux-headers` package installed)

```
sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
```

Create a NVIDIA .conf file:
```
echo "options nvidia-drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf
```

and verify by running command below, output should be `options nvidia-drm modeset=1`
```
cat /etc/modprobe.d/nvidia.conf
```
<br/>

### Step 3

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

## Future Reference/Personalisation
- [Auto-login on TTY1](https://wiki.archlinux.org/title/Getty#Automatic_login_to_virtual_console)



[comment]: <> (This is a comment, it will not be included)
[comment]: <> (in  the output file unless you use it in)
[comment]: <> (a reference style link.)
<!-- your comment -->
[//]: <> (This is also a comment.)
[//]: # (This may be the most platform independent comment)
## References:
https://github.com/astonish-g/hypr-catppuccin-dotfiles/tree/main
