#!/bin/bash
#------------------------------------------------------------------------------
# ~/.xinitrc
#
# Author: adedomme 
# Last modified: Wed Aug 15, 2012 05:11PM
#
#------------------------------------------------------------------------------

export SSH_ASKPASS="/usr/bin/ssh-askpass"
setxkbmap fr

xsetroot -solid '#101010'
ssh-add < /dev/null
exec i3
