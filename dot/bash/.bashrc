#!/bin/bash

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;;
esac

# Enable .shellrc, file to use wih most popular shells to not duplicate code.
if [ -f ~/.shellrc ]; then
    source ~/.shellrc
fi

# History file
## Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
## Append to the history file, don't overwrite it.
shopt -s histappend
HISTSIZE=1000000
HISTFILESIZE=$HISTSIZE

# Prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Misc
## Update window size.
shopt -s checkwinsize
## Enable tab-completion.
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi