#!/bin/zsh

#               ▗▖             
#               ▐▌             
#     ▐███▌▗▟██▖▐▙██▖ █▟█▌ ▟██▖
#       ▗▛ ▐▙▄▖▘▐▛ ▐▌ █▘  ▐▛  ▘
#      ▗▛   ▀▀█▖▐▌ ▐▌ █   ▐▌   
#  █  ▗█▄▄▖▐▄▄▟▌▐▌ ▐▌ █   ▝█▄▄▌
#  ▀  ▝▀▀▀▘ ▀▀▀ ▝▘ ▝▘ ▀    ▝▀▀ 
#                              
#
# (C) Grzesiek11 2019
# Licensed under GNU GPL v3.0.
# https://gitlab.com/grzesiek11/dotfiles

## Enable .shellrc, file to use wih most popular shells to not duplicate code.
if [ -f ~/.shellrc ]; then
    source ~/.shellrc
fi

# ZSHDIR

## Set ZSHDIR.
ZSHDIR="$HOME/.zsh.d"
## Display warning, if not found.
if [[ ! -x $ZSHDIR ]]; then;
    echo "Warning! no $ZSHDIR found!";
fi

# Tab-completion

## Initialize.
autoload -Uz compinit
compinit
## Open tab-completion menu instead of just showing all items.
zstyle ':completion:*' menu select

# Autocorrection

## Enable autocorrection
setopt correctall

# Prompt

## Initialize.
autoload -U promptinit
promptinit
## Theming.
#if [[ -z $DISPLAY ]]; then
#    # Basic bash prompt if in TTY.
#    source "$ZSHDIR/prompts/bash.zsh"
#else
#    # And more advanced xterm prompt.
#    source "$ZSHDIR/prompts/hardX-11.zsh"
#fi
source "$ZSHDIR/prompts/simple.zsh"

# History

## Enable history.
HISTFILE=$HOME/.zsh_history
## Set line limit to maximum.
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
## Ignore duplicates and empty commands to save space.
setopt hist_ignore_all_dups
setopt hist_ignore_space
# Save immediatelly after entering command.
setopt share_history

# Keybindings

## C-left and C-right to move cursor by word.
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word

# Command editor

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Miscellaneous

## Type directory name to enter it.
setopt autocd
## Use color in shell.
use_color=true
## Change the window title of xterm.
case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;${USER}@${HOST}:${PWD/#$HOME/\~}\a"};;
esac
## Allow for code execution in prompts.
setopt prompt_subst

# Extensions

## zsh-autosuggestions
. $ZSHDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
## zsh-syntax-highlighting
. $ZSHDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
## Code::Stats
source ~/.zsh.d/zsh-codestats/codestats.zsh
