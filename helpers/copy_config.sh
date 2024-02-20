# Script to copy existing configs OR modify existing configs

echo 'Running config migration'

echo 'Copying default waybar config files.'
# cp -r /etc/xdg/waybar/ $HOME/.config/
cp -r .config/waybar/ $HOME/.config/

echo 'Migrating existing hypr-min config files'
cp -r ../.config/hypr/ $HOME/.config/

echo 'finished'
