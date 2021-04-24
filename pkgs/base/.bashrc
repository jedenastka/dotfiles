# Load enviroment variables
if [ -n "$XDG_CONFIG_HOME" ]; then
    source "$XDG_CONFIG_HOME/env"
else
    source "$HOME/.config/env"
fi

# If not running interactively, exit
case $- in
    *i*) ;;
      *) return;;
esac

# Load aliases and functions
source "$XDG_CONFIG_HOME/shell/aliases"
source "$XDG_CONFIG_HOME/shell/functions"

# History
## Change the location of the history file
HISTFILE="$XDG_DATA_HOME"/bash/history
## One bilion of saved lines is certainly enough
HISTSIZE=1000000000
HISTFILESIZE="$HISTSIZE"
## Ignore empty lines and duplicates
HISTCONTROL=ignoreboth
## Append instead of overwriting
shopt -s histappend

# Update the terminal size after executing a command
shopt -s checkwinsize

# Allow the '**' glob
shopt -s globstar

# Prompt setup
## Enable colors
color_prompt=yes
## Check if the terminal supports colors
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
## Check if in a chroot
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
## Set the prompt
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

# Set the xterm window title
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Define LS_COLORS
eval "$(dircolors -b)"

# Colorful output in commands
## ls
eval "$(dircolors -b)"
## gcc
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Command completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi