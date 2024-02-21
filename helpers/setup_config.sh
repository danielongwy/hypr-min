# Script to copy existing configs OR modify existing configs

main_config="$HOME/.config"

#echo 'Running config migration'
#
#echo 'Copying default waybar config files.'
## cp -r /etc/xdg/waybar/ $HOME/.config/
#cp -r .config/waybar/ $main_config
#
#echo 'Migrating existing hypr-min config files'
#cp -r .config/hypr/ $main_config
#
#echo 'Copying .config/xfce4/'
#cp -r .config/xfce4/ $main_config
#
#
#
#sudo sed -i "0,/#Color/s//Color/" /etc/pacman.conf
#
mkdir $main_config/gtk-3.0
cp -r .config/gtk-3.0/bookmarks $main_config/gtk-3.0

starship preset gruvbox-rainbow -o ~/.config/starship.toml

echo 'finished'
