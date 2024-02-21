#
# ~/.bash_profile
#

if [[ $(tty) == "/dev/tty1" ]]; then
    # Action to perform when running on tty1
    echo "This session is running on tty1."
    Hyprland
    # Add your desired commands or actions here
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
