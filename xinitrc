#!/bin/bash
#------------------------------------------------------------------------------
# ~/.xinitrc
#
# Author: adedommelin
# Last modified: Sun Nov 11, 2012 08:45PM
#
#------------------------------------------------------------------------------
export SSH_ASKPASS="/usr/bin/ssh-askpass"
setxkbmap fr

xsetroot -solid '#101010'
ssh-add < /dev/null
exec i3
