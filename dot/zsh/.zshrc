#!/bin/zsh

ZSHDIR="$HOME/.zsh.d"
if [[ ! -x $ZSHDIR ]]; then;
    echo "Warning! no $ZSHDIR found!";
fi

# Completion.
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
# Advanced tab-completion.
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' menu select

# Correction.
setopt correctall

# Prompt init.
autoload -U promptinit
promptinit

# History.
HISTFILE=$HOME/.zsh_history
HISTSIZE=999999
SAVEHIST=$HISTSIZE
# ignore duplicates
setopt hist_ignore_all_dups
# ignore space
setopt hist_ignore_space
# save immediatelly
setopt share_history

# Keybindings.
# ctrl-left and ctrl-right
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word

# Miscellaneous settings.
setopt autocd
setopt extendedglob
use_color=true

# Command Editor.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Change the window title of xterm.
case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;${USER}@${HOST}:${PWD/#$HOME/\~}\a"};;
esac

# Theming.
# git prompt
setopt PROMPT_SUBST
. $ZSHDIR/git-prompt.sh
# source themes
if [[ -z $DISPLAY ]]; then
    # tty
   . "$ZSHDIR/bash.zsh-theme"
else
    # xterm
    . "$ZSHDIR/11hardX.zsh-theme"
fi

# zsh-autosuggestions
. $ZSHDIR/zsh-autosuggestions.zsh

# Syntax highlighting
. $ZSHDIR/highlighting/zsh-syntax-highlighting.zsh

# Code::Stats
CODESTATS_API_KEY="SFMyNTY.UjNKNlpYTnBaV3N4TVE9PSMjTnpBNE1BPT0.W4sgIYvRpnFx29-P04seduc8j3iWe-iPeHVBEPZjNoo"
source ~/.zsh.d/codestats.zsh

# Enable .shellrc, file to use wih most popular shells to not duplicate code
if [ -f ~/.shellrc ]; then
    source ~/.shellrc
fi
