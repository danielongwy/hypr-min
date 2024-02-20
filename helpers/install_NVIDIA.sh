#!/bin/bash
# https://github.com/danielongwy/hypr-min
source ./util.sh

# Step 1: Install required dependencies
yay -S --needed --noconfirm linux-headers nvidia-dkms qt5-wayland qt5ct libva libva-nvidia-driver-git

# Step 2: Update GRUB
initial_line='GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"'
replaced_line='GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet nvidia_drm.modeset=1"'
grub_file='/etc/default/grub'
original_content=$(cat $grub_file)


# File replacement with sed
sudo sed -i "0,/$initial_line/s//$replaced_line/" $grub_file


# Check if replacement worked base on file diff (only works once, which is by design)
echo
if [[ $original_content != $(cat $grub_file) ]]; then	
	echo -e "$COK - Updated GRUB file"
else
	echo -e "$CER - Unable to update GRUB file, check /etc/default/grub"
fi
echo
# Rebuild GRUB
sudo grub-mkconfig -o /boot/grub/grub.cfg


# Step 3: Update initramfs
initial_line='MODULES=()'
replaced_line='MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)'
mkinitcpio_file='/etc/mkinitcpio.conf'
original_content=$(cat $mkinitcpio_file)

# File replacement with sed
sudo sed -i "0,/$initial_line/s//$replaced_line/" $mkinitcpio_file

echo
# Same as GRUB check, diff works only once
if [[ $original_content != $(cat $mkinitcpio_file) ]]; then	
	echo -e "$COK - Updated $mkinitcpio_file"
else
	echo -e "$CER - Unable to update $mkinitcpio_file"
fi
echo

# Generate initframfs image
sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img


# Step 4: Create NVIDIA .conf file

file_contents="options nvidia-drm modeset=1"
nvidia_file="/etc/modprobe.d/nvidia.conf"
echo $file_contents | sudo tee $nvidia_file > /dev/null

verify=$(cat /etc/modprobe.d/nvidia.conf)

echo
if [[ $verify == $file_contents ]]; then
	echo -e "$COK - $nvidia_file created successfully"
else
	echo -e "$CER - Unexpected error creating /etc/modprobe.d/nvidia.conf"
fi
