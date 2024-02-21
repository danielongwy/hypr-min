#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# General Use
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cls='clear'

# Navigation Shortcuts
alias down='cd ~/Downloads'
alias mhh='cd ~/Downloads/hypr-min'

# Checking things
alias kittyavailfont='kitty list-fonts'
alias kittyfont='kitty --debug-font-fallback'
alias eyeit='hyprctl clients'

# Config quick edit
alias ehh='nvim $HOME/.config/hypr/hyprland.conf'
alias ebb='nvim $HOME/.bashrc'

# Exports
alias exx="~/Downloads/hypr-min/helpers/export_config.sh ~/Downloads/hypr-min"

# Debugging
alias badcommit="git add . && git commit -m\"BAD\" && git push"
alias ess='source ~/.bashrc'
alias edd='nvim ~/Downloads/hypr-min/helpers/export_config.sh'
eval "$(starship init bash)"
