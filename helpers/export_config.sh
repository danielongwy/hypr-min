#!/bin/bash
# Colors

COK="[\e[1;32mOK\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"

if [ ! -z "$1" ]; then
	path=$1
	config=$1/.config

	echo "Destination: $config"


	cp ~/.bashrc ~/.bash_profile $path
	cp -r ~/.config/hypr/ $config
	cp -r ~/.config/waybar/ $config
	cp -r ~/.config/kitty/ $config
	cp -r ~/.config/nvim $config
	cp -r ~/.config/xfce4/ $config
	cp -r ~/.config/gtk-3.0/ $config
	
	echo -e "$COK - Backup done"
else
	echo -e "$CAC - Missing file destination as first argument."
fi


