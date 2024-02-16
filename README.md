# Minimal installation of Hyprland(Repo) + Arch Linux


- Terminal: kitty
- File Manager: dolphin
- Unix Text Editor: neovim
- Wallpaper: Hyprpaper
- Status Bar: Waybar
- Notification Daemon: Dunst
- Terminal: kitty
- Logout: wlogout 
- Image viewer: imv
- Video Player: mpv
- PDF Viewer: ?
- Color Picker: hyprpicker
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



## Other packages:
- qt5-wayland
- qt6-wayland
- qt5ct
- qt6ct 
- xdg-desktop-portal-gtk (Reccomended for `file picker` in Hyprland Wiki)



must_have=(
    pipewire
    wireplumber
    polkit-kde-agent
    qt5-wayland
    qt6-wayland
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
)

# Authentication Agent 
> sudo pacman -S polkit-kde-agent
## Export to hyprland conf
> exec-once=/usr/lib/polkit-kde-authentication-agent-1


# Setting Up NVIDIA with Hyprland
###### More details in the [Official Hyprland Wiki](https://wiki.hyprland.org/Nvidia/)
*Note*: `nvim` can be replace with a command-line text editor of your choice

Install required dependancies:

```
yay -S linux-headers nvidia-dkms qt5-wayland qt5ct libva libva-nvidia-driver-git
```


Add `nvidia_drm.modeset=1` to the end of `GRUB_CMDLINE_LINUX_DEFAULT=` in `/etc/default/grub`

```
nvidia_drm.modeset=1
```
```
sudo nvim /etc/default/grub
```

For `systemd-boot` see [here](http://wiki.hyprland.org/Nvidia/#how-to-get-hyprland-to-possibly-work-on-nvidia).


Add to 'modules' in '/etc/mkinitcpio.conf':

```
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```
```
sudo nvim /etc/mkinitcpio.conf
```


Generate a new initramfs image (Must have `linux-headers` package installed):

```
sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
```

## Create a NVIDIA conf
> echo "options nvidia-drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf

## Verify by running command below, output should match 'options nvidia-drm modeset=1'
> cat /etc/modprobe.d/nvidia.conf

## Export these variables to hyprland.conf
> env = LIBVA_DRIVER_NAME,nvidia
> env = XDG_SESSION_TYPE,wayland
> env = GBM_BACKEND,nvidia-drm
> env = __GLX_VENDOR_LIBRARY_NAME,nvidia
> env = WLR_NO_HARDWARE_CURSORS,1

or

> echo "env = LIBVA_DRIVER_NAME,nvidia\n env = XDG_SESSION_TYPE,wayland\n env = GBM_BACKEND,nvidia-drm\n env = __GLX_VENDOR_LIBRARY_NAME,nvidia\n env = WLR_NO_HARDWARE_CURSORS,1" >> /$HOME/.config/hypr/hyprland.conf

# Reboot your system
> systemctl reboot



