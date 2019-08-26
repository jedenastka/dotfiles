#!/bin/bash

# (C) Grzesiek11 2019
# Licensed under GNU GPL v3.0.
# https://gitlab.com/grzesiek11/dotfiles

if [ -x /usr/bin/stow ]; then
    echo "Stow exists. Everything OK."
else
    echo "Stow is missing! Install stow and continue."
    exit
fi

echo "Installing dotfiles in $HOME..."
echo "Any old dotfiles will be moved to $PWD/dotfiles.old."

for package in $(ls dot); do
    echo "Stowing $package..."
    while [ true ]; do
        conflicts=$(stow -R -t $HOME -d dot $package 2>&1 | awk '/\* existing target is/ {print $NF}')
        for conflict in $conflicts; do
            echo "Detected conflict: $conflict exists."
            mkdir -p dotfiles.old
            mv $HOME/$conflict dotfiles.old
        done
        [ -z "$conflicts" ] && break
    done
done

echo "Done!"

echo "Creating local configs..."

LOCAL_FILES=(~/.shellrc-local ~/.xsessionrc-local ~/.shell-profile-local ~/.vim/vimrc-local)
for FILE in ${LOCAL_FILES[*]}; do
    echo "Creating '$FILE'..."
    touch $FILE
done

echo "Done!"