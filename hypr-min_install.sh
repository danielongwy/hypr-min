#!/bin/bash

# hypr-min By danielongwy - https://github.com/danielongwy/hypr-min
# License - MIT License

# IMPORTANT - This script is meant to be run on a fresh MINIMAL install of Arch on physical hardware.
# The following will attempt to install Hyprland based on the official documentation - https://wiki.hyprland.org/Getting-Started/Master-Tutorial/ 
# Only Hyprland and reccomended 'must haves' will be installed, see README for more info on packages. 

echo 'Installing hypr-min'

sudo pacman -Syu

hyprland_core=(
	hyprland
	kitty
	git
	dolphin
	neovim
	firefox
)


for ea in ${hyprland_core[@]}; do
	echo
	echo 'Installing' $ea
	sudo pacman -S --needed $str	
done

# Run external script to install yay
source ./Scripts/install_yay.sh

# Hyprland Must Haves
# Portal Ref: https://wiki.hyprland.org/0.22.0beta/Useful-Utilities/Hyprland-desktop-portal/
must_have=(
	dunst
	pipewire
	wireplumber
	xdg-desktop-portal-hyprland
	polkit-kde-agent
	qt5-wayland
	qt6-wayland
)

for ea in ${must_have[@]}; do
	yay -S --needed $ea
done

# Add clipboard manager
optional_cores=(
	qt5ct
	waybar
	hyprpaper
	hyprpicker
	udiskie
	rofi
)

for ea in ${optional_cores[@]}; do
	yay -S --needed $ea
done

# Run conf migration
cd
cd hypr-min
source ./Scripts/dot_config_migration.sh
