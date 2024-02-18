#!/bin/bash
# https://github.com/Jguer/yay

echo 'Attempting to install yay\n'

sudo pacman -Syu
sudo pacman -S --needed git base-devel 

cd
git clone https://aur.archlinux.org/yay.git
makepkg -si --noconfirm


# Generate 'development pacakage' database for *-git packages. Should only be run once.
yay -Y --gendb

# Check for 'development packagage' updates
#yay -Syu --devel

#Use yay -Y --devel --save to make development package updates permanently enabled (yay and yay -Syu will then always check dev packages)
yay -Syu --devel --save

cd
