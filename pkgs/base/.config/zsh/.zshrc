# Load enviroment variables
if [ -n "$XDG_CONFIG_HOME" ]; then
    source "$XDG_CONFIG_HOME/env"
else
    source "$HOME/.config/env"
fi

# Load aliases and functions
source "$XDG_CONFIG_HOME/shell/aliases"
source "$XDG_CONFIG_HOME/shell/functions"

# Colorful output in commands
## ls
eval "$(dircolors -b)"
## gcc
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Set up the prompt
#autoload -Uz promptinit
#promptinit
#prompt adam1
source "$ZDOTDIR/prompts/simple.prompt.zsh"

# emacs keybindings
bindkey -e

# History
## One bilion of saved lines is certainly enough
HISTSIZE=1000000000
SAVEHIST="$HISTSIZE"
## Change the location of the history file
HISTFILE="$XDG_DATA_HOME/zsh/history"
## Advanced history format
setopt extendedhistory
## Write on command, not on exit
setopt incappendhistory
## Share between sessions
setopt sharehistory
## Deduplicate
setopt histexpiredupsfirst histignoredups histignorealldups histfindnodups histsavenodups
## Delete useless whitespace
setopt histreduceblanks
## Verify
setopt histverify

# Command completion
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Type a path to change into it
setopt autocd

# Enable comments in the interactive shell
setopt interactivecomments

# Keyword correction
setopt correctall

# Keybinds
# Ctrl+E to open the command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-e' edit-command-line
# Ctrl+arrows to move cursor by word
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word
bindkey '^ ' forward-word
# Ctrl+(Backspace|Delete) to remove word
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

# Load Tetris
autoload -Uz tetriscurses

# WIP
precmd() {
    print -Pn "\e]0;%~ (%m)\a"
}

preexec() {
    print -Pn "\e]0;%~: $(echo "$1" | cut -d' ' -f1) (%m)\a"
}

# Configure sdkman
[ -f "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Configure rustup
[ -f "$XDG_DATA_HOME/cargo/env" ] && source "$XDG_DATA_HOME/cargo/env"

# Configure command-not-found
[ -f '/etc/zsh_command_not_found' ] && source '/etc/zsh_command_not_found'

# Configure pyenv
export PYENV_ROOT="$HOME/.local/share/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
[ -n "$(command -v pyenv)" ] && eval "$(pyenv init -)"

# Load plugins
## zsh-autosuggestions
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
## zsh-syntax-highlighting
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
