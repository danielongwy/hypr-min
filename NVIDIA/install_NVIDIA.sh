#!/bin/bash

yay -S --needed -noconfirm linux-headers nvidia-dkms qt5-wayland qt5ct libva libva-nvidia-driver-git


initial_line='GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"'
replaced_line='GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet nvidia_drm.modeset=1"'
grub_file='/etc/default/grub'

original_content=$(cat $grub_file)
sudo sed -i "0,/$initial_line/s//$replaced_line/" $grub_file

if [[ $original_content != $(cat $grub_file) ]]; then	
	echo "[OK] - Updated GRUB file"
else
	echo "[ERROR] - Unable to update GRUB file, check /etc/default/grub"
fi

sudo grub-mkconfig -o /boot/grub/grub.cfg


# Step 3

initial_line='MODULES=()'
replaced_line='MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)'
mkinitcpio_file='/etc/mkinitcpio.conf'

original_content=$(cat $mkinitcpio_file)
sudo sed -i "0,/$initial_line/s//$replaced_line/" $mkinitcpio_file


# Generate initframfs image
sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img

# Step 4
echo "options nvidia-drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf > /dev/null
verify=$(cat /etc/modprobe.d/nvidia.conf)

if [[ $verify == "options nvidia-drm modeset=1" ]]; then
	echo "verified, can reboot"
else
	echo "[ERROR] - Unexpected error creating /etc/modprobe.d/nvidia.conf"
fi

