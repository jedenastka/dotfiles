#!/bin/bash

PWD_PART=" %K{black}%F{white}${PWD//"$HOME"/"~"}"
if [ "$PWD_PART" != "/" ]; then
    PWD_PART="${PWD_PART//'/'/" \ue0b0 "}"
fi
PWD_PART="${PWD_PART/" \ue0b0 "/'/ \ue0b0 '}"

USER_PART=" $USER \ue0b0 $HOSTNAME \ue0b0"

END_PART=" \ue0b0 "

printf "$USER_PART$PWD_PART$END_PART"