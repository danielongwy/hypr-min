# Script to copy existing configs OR modify existing configs

echo 'Running config migration'

echo 'Copying default waybar config files.'
cp -r /etc/xdg/waybar/ $HOME/.config/
# Update to migrate existing waybar

echo 'Migrating existing hypr-min config files'
cp -r ./Configs/hypr/ $HOME/.config/

echo 'finished'
