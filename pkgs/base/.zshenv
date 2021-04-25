# Load enviroment variables
if [ -n "$XDG_CONFIG_HOME" ]; then
    source "$XDG_CONFIG_HOME/env"
else
    source "$HOME/.config/env"
fi

# Move the zsh configuration elsewhere
ZDOTDIR="$XDG_CONFIG_HOME/zsh"
