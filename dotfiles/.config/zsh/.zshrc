# Source enviroment variables
[ -e ~/.config/env ] && source ~/.config/env

# Source shell-independent config
[ -e ~/.config/shell/rc ] && source ~/.config/shell/rc

# Set up the prompt
autoload -Uz promptinit
promptinit
source "$ZDOTDIR/prompts/simple.prompt.zsh"

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Set up history
# I took most options from https://unix.stackexchange.com/questions/273861/unlimited-history-in-zsh
HISTFILE=$XDG_DATA_HOME/zsh_history
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

# Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# Correction
setopt correctall

# Type path to cd to it
setopt autocd

# Allow for code execution in prompts
setopt prompt_subst

# Enable comments
setopt interactivecomments

# Keybinds
# Command editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-e' edit-command-line
# Ctrl+Arrows to move cursor by word
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word
bindkey "^ " forward-word
# Ctrl+Backspace to remove word
bindkey "^H" backward-kill-word

# Load Tetris so I can play it when I'm bored
autoload -Uz tetriscurses

# Plugins
# Code::Stats
source $ZDOTDIR/plugins/codestats/codestats.plugin.zsh
# Autosuggestions
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
# Syntax highlighting
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
