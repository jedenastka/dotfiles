#!/bin/sh

echo "Installing dotfiles in $HOME..."
echo "Any old dotfiles will be moved to $PWD/dotfiles.old."

for package in $(ls dot); do
    echo "Stowing $package..."
    while [ true ]; do
        conflicts=$(stow -t $HOME -d dot $package 2>&1 | awk '/\* existing target is/ {print $NF}')
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