#!/bin/zsh

if [ -z $TMUX ]; then
    PROMPT=$'%F{10}%n@%m%F{white}:%F{12}%~%F{white}$%f '
else
    PROMPT=$'%F{green}%n@%m%F{white}:%F{blue}%~%F{white}$%f '
fi