#------------------------------------------------------------------------------
# ~/.bashrc
#
# Author: adedommelin
# Last modified: Sun Jan 20, 2013 04:23PM
#
#------------------------------------------------------------------------------

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s checkwinsize

PATH=$PATH:~/bin:/sbin:/usr/sbin:/usr/local/sbin


#------------------------------------------------------------------------------
# Cosmetics
#------------------------------------------------------------------------------
source ~/.dotfiles/_liquidprompt/liquidprompt

#------------------------------------------------------------------------------
# Aliases
#------------------------------------------------------------------------------
# Package Management
alias apt-get='sudo apt-get'
alias deborphan='deborphan -Pzns --libdevel'
alias aptgi='sudo apt-get install'
alias aptcs='apt-cache search'
alias aptchow='apt-cache show'
alias aptgr='sudo apt-get remove'
alias aptgrp='sudo apt-get remove --purge'
alias aptgc='sudo apt-get clean'
alias miseajourdebian='sudo apt-get update && sudo apt-get dist-upgrade --verbose-versions'

# mine* aliases
alias minefaisvoirleslogs='sudo tail -f /var/log/syslog /var/log/auth.log'
alias mineyapudeplace='du -sxh --block-size=1024K * | sort -nr | head -10'
alias minedatemoicadanstaface="date '+%F--%H%M%S'"
alias minedate-rfc822="date '+%a, %d %b %Y %X %z'"
alias minebackuppascher='tar --preserve -cvzf'
alias minescreen='screen -DR'
alias minegetmyip='wget -q -O - http://www.tuxz.net/ip.php;echo -e ""'
alias mineluksopen='sudo cryptsetup luksOpen /dev/sdb1 usbKey && sudo mount /dev/mapper/usbKey /mnt/usb'
alias mineluksclose='cd / ; sudo umount /mnt/usb ; sudo cryptsetup luksClose /dev/mapper/usbKey'
alias minefilemoiunpassword='tr -cd "[:graph:]" < /dev/urandom | head -c 40;echo ""'

# rhooooo my CLI
alias ls='ls --color=always'
alias l='ls --color=always -lAhrt'
alias lla='ls --color=always -lAh'
alias ll='ls --color=always -lh'
alias lsd='ls -ld *(/)'
alias lad='ls -ld .*(/)'
alias lsa='ls -a .*(.)'
alias lsbig='ls -lSh *(.) | tail'
alias lssmall='ls -Sl *(.) | head'
alias lsnew='ls -rtl *(.) | tail '
alias rm='rm -f'
alias cp='cp -f'
alias mv='mv -f'
alias df='df -h'
alias du='du -sh'
alias grep='grep --color=auto'
alias h='history'
alias e\?='echo $?'
alias psg='ps aux| grep -v grep | grep -i '
alias cd..='cd ..'
alias rw-='chmod 600'
alias rwx='chmod 700'
alias r--='chmod 644'
alias r-x='chmod 755'
alias UP2low='for i in *(.); mv $i ${i:l}'
alias low2UP='for i in *(.); mv $i ${i:u}'
alias d='dirs -v'
alias vi='vim'
alias vim="vim -p"
alias akcurl='curl -I -H "Pragma: akamai-x-cache-on, akamai-x-cache-remote-on, akamai-x-check-cacheable, akamai-x-get-cache-key, akamai-x-get-extracted-values, akamai-x-get-nonces, akamai-x-get-ssl-client-session-id, akamai-x-get-true-cache-key, akamai-x-serial-no"'
alias ant='ant -logger org.apache.tools.ant.listener.AnsiColorLogger'


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
