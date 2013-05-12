#!/bin/bash
#------------------------------------------------------------------------------
# ~/.xinitrc
#
# Author: adedommelin
# Last modified: Tue Apr 30, 2013 10:22PM
#
#------------------------------------------------------------------------------
export SSH_ASKPASS="/usr/bin/ssh-askpass"
setxkbmap fr

xsetroot -solid '#101010'
ssh-add < /dev/null
xrdb -load ~/.Xdefaults

exec i3
