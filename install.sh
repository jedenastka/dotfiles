#!/bin/sh

echo "Installing dotfiles in $HOME..."

for package in $(ls dot); do
    echo "Stowing $package..."
    conflicts=$(stow -t $HOME -d dot $package 2>&1 | awk '/\* existing target is/ {print $NF}')
    #stow -t $HOME -d dot $package
    for conflict in $conflicts; do
        echo "Detected conflict: $conflict exists."
        mkdir -p $HOME/old_dotfiles
        mv $HOME/$conflict $HOME/dotfiles.old
    done
done

echo "Done!"

echo "Creating local configs..."