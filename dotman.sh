#!/bin/bash

# (C) Grzesiek11 2019
# Licensed under GNU GPL v3.0.
# https://gitlab.com/grzesiek11/dotfiles

echo "DotfilesManager v2.1"
echo "(C) Grzesiek11 2019"
echo "Licensed under GNU GPL v3.0."
echo

notImplemented() {
echo "This function is not implemented yet."
}

checkStow() {
if command -v stow >/dev/null 2>&1; then
    echo "Stow exists. Everything OK."
else
    echo "Stow is missing! Install stow and continue."
    exit
fi
}

dotInstall() {
checkStow
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
}

dotUninstall() {
notImplemented
}

dotReinstall() {
dotUninstall
dotInstall
}

helpMsg() {
echo "Help:"
echo "install - Installs dotfiles."
echo "uninstall - Removes dotfiles."
echo "reinstall - Removes, and then installs dotfiles."
echo "help - Shows this message"
}

if [ -z "$1" ]; then
    echo "No parameter entered. Try 'help'." 
elif [ "$1" = "help" ]; then
    helpMsg
elif [ "$1" = "install" ]; then
    dotInstall
elif [ "$1" = "uninstall" ]; then
    dotUninstall
elif [ "$1" = "uninstall" ]; then
    dotReinstall
else
    echo "There is no '$1' parameter. Try 'help'."
fi
exit
