#!/bin/bash

# hypr-min By danielongwy - https://github.com/danielongwy/hypr-min
# License - MIT License

# IMPORTANT - This script is meant to be run on a fresh MINIMAL install of Arch on physical hardware.
# The following will attempt to install Hyprland based on the official documentation - https://wiki.hyprland.org/Getting-Started/Master-Tutorial/ 
# Only Hyprland and reccomended 'must haves' will be installed, see README for more info on packages. 

echo 'Installing hypr-min'

sudo pacman -Syu


# Install yay (external script)
source ./scripts/install_yay.sh
supporting_packages=(
	qt5-wayland
	qt6-wayland
	qt5ct
	qt6ct
	xdg-desktop-portal-hyprland
	xdg-desktop-portal-gtk
	xdg-users-dirs
	pipwire-jack
	)

hyprland_core=(
	git
	hyprland
	kitty
	thunar
	neovim
	firefox
	hyprpaper
	waybar
	dunst
	imv
	mpv
	pipwire
	wireplumber
	btop
	polkit-kde-agent
	starship
)

core_support=(
	thunar-volman
	thunar-archieve-plugins
	gvfs
	xarchiever
	tumbler
)

themeing=(
	nwg-look-bin
	kvantum
	papirus-icon-theme
	noto-fonts-emoji
	noto-fonts-cjk
	ttf-firacode-nerd
	)




for ea in ${supporting_packages[@]}; do
	echo
	echo 'Installing' $ea
	yay -S --needed $ea
done

for ea in ${hyprland_core[@]}; do
	echo
	echo 'Installing' $ea
	yay -S --needed $ea
done
for ea in ${core_support[@]}; do
	echo
	echo 'Installing' $ea
	yay -S --needed $ea
done


for ea in ${themeing[@]}; do
	echo
	echo 'Installing' $ea
	yay -S --needed $ea
done


# Run conf migration
source ./scripts/dot_config_migration.sh

echo 'install complete, run hyprland'
