#!/bin/bash

# (C) Grzesiek11 2019
# Licensed under GNU GPL v3.0.
# https://gitlab.com/grzesiek11/dotfiles

installPath=$HOME
oldPath=$PWD/dotfiles.old

echo "DotfilesManager v2.2"
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

#dotBaseLoop() {
#
#}

dotInstall() {
checkStow
echo "Installing dotfiles in '$installPath'..."
echo "Any old dotfiles will be moved to '$oldPath'."

for package in $(ls dot); do
    echo "Installing $package..."
    while [ true ]; do
        conflicts=$(stow -S -t $installPath -d dot $package 2>&1 | awk '/\* existing target is/ {print $NF}')
        for conflict in $conflicts; do
            echo "Detected conflict: $conflict exists."
            mkdir -p $oldPath
            mv $installPath/$conflict $oldPath
        done
        [ -z "$conflicts" ] && break
    done
done

echo "Done!"

echo "Creating local configs..."

localFiles=(~/.shellrc-local ~/.xsessionrc-local ~/.shell-profile-local ~/.vim/vimrc-local)
for file in ${localFiles[*]}; do
    echo "Creating '$file'..."
    touch $file
done

echo "Done!"

echo "Configuring DOTDIR variable..."

echo "export DOTDIR=$PWD" | tee -a "$installPath/.shellrc-local"

echo "Done!"
}

dotUninstall() {
checkStow

echo "Uninstalling dotfiles from '$installPath'..."
for package in $(ls dot); do
    echo "Uninstalling $package..."
    stow -D -t $installPath -d dot $package 2>&1 > /dev/null
done

echo "Done."
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
