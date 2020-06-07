# Source shell-independent config

[ -e ~/.config/shell/rc ] && source ~/.config/shell/rc

# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Set up history
# I took most options from https://unix.stackexchange.com/questions/273861/unlimited-history-in-zsh
HISTFILE=$XDG_CACHE_HOME/zsh_history
HISTSIZE=10000000
SAVEHIST=$HISTSIZE
# Super-advanced history format
setopt EXTENDED_HISTORY
# Write to history all the time, not on exit.
setopt INC_APPEND_HISTORY
# Share between sessions
setopt SHARE_HISTORY
# Ignore and delete duplicates
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
# Don't save if starts with space
setopt HIST_IGNORE_SPACE
# Delete unnessesary spaces
setopt HIST_REDUCE_BLANKS
# "Don't execute immediately upon history expansion.", whatever it means - sounds good to me anyways
setopt HIST_VERIFY

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
