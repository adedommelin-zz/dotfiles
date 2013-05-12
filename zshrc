#------------------------------------------------------------------------------
# ~/.zshrc
#
# Author: adedommelin
# Last modified: Fri Feb 01, 2013 09:08AM
#
#------------------------------------------------------------------------------

autoload -U zutil
autoload -U compinit
autoload -U complist
compinit
export LISTPROMPT       # in order to scroll if completion list is too big
setopt auto_cd          # a commande like % /usr/local is equivalent to cd /usr/local
setopt nohup            # don't send HUP signal when closing term session
#setopt extended_glob    # in order to use #, ~ and ^ for filename generation
setopt always_to_end    # move to cursor to the end after completion
setopt notify         	# report the status of backgrounds jobs immediately
setopt correct          # try to correct the spelling if possible
setopt rmstarwait       # wait 10 seconds before querying for a rm which contains a *
setopt auto_pushd       # Always push directory in stack
setopt pushdminus       # Invert the behavior of cd -<tab> cd +<tab>
export DIRSTACKSIZE=20  # Number of directory to keep in the stack
set -C 			            # Don't erase file with >, use >| (overwrite) or >> (append) instead
watch=(all)		          # Watch for new users

HISTFILE=~/.zsh_history
HISTSIZE=SAVEHIST=10000
setopt incappendhistory 
setopt sharehistory
setopt extendedhistory

WORDCHARS='*?_-[]~\!#$%^(){}<>|`@#$%^*()+:?'


#------------------------------------------------------------------------------
# Cosmetics 
#------------------------------------------------------------------------------
#export date_color="white"
#export user_color="white"
#export host_color="white"
#export path_color="green"
#
#autoload -U colors
#setopt prompt_subst
#colors
#
#date_format="%H:%M"
#date="%{$fg[$date_color]%}%D{$date_format}"
#host="%{$fg[$user_color]%}%n%{$reset_color%}~%{$fg[$host_color]%}%m"
#cpath="%{$fg[$path_color]%}\$PATHINFO%b"
#end="%{$reset_color%}"
#
#precmd () { 
#  if [ -d $PWD/.svn ] ; then
#    PATHINFO="(svn):$PWD"
#  else
#    PATHINFO=$PWD
#  fi
#}

#PS1="$date ($host$end) $cpath
#$end%% "

#export PS1

source ~/.dotfiles/_liquidprompt/liquidprompt


#------------------------------------------------------------------------------
# Extended completion 
#------------------------------------------------------------------------------
local _myhosts _myuser
local _ssh_hosts

if [ -r $HOME/.ssh/known_hosts ] ; then
  _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*})
fi

_ssh_hosts=(${_ssh_hosts:#|1|*})
_myhosts=($_ssh_hosts)

zstyle ':completion:*' hosts $_myhosts
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*:*:zless:*' file-patterns '*(-/):directories *.gz:all-files'
zstyle ':completion:*:*:geeqie:*' file-patterns '*(-/):directories :*.(png|jpeg|jpg):all-files'
zstyle ':completion:*:*:lintian:*' file-patterns '*(-/):directories *.deb'
zstyle ':completion:*:*:less:*' ignored-patterns '*.gz'
zstyle ':completion:*:*:zcompile:*' ignored-patterns '(*~|*.zwc)'
zstyle ':completion:*:*:vim:*' file-sort modification
zstyle ':completion:*:*:vim:*' ignored-patterns '*.o'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}



#------------------------------------------------------------------------------
# Environment variables 
#------------------------------------------------------------------------------
export DEBFULLNAME="Alexandre De Dommelin"
export DEBEMAIL="adedommelin@tuxz.net"
export LC_ALL=en_US.UTF-8
export LC_LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export HTTP_PROXY=""
export TERM="xterm"
export PAGER="less"
export LESS="-ir"

if [ -x $(which -p vim) ]; then 
  alias vi="vim"
  export EDITOR=vim
  export VISUAL=vim
fi

[ -d /usr/local/info ] && export INFO_PATH="$INFO_PATH;/usr/local/info"

PATH=$PATH:~/bin:/sbin:/usr/sbin:/usr/local/sbin


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
alias minedodo='echo "mem" | sudo tee /sys/power/state'

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


#------------------------------------------------------------------------------
# Functions  
#------------------------------------------------------------------------------
minecestquoiceport() {
	grep $1 /etc/services
}

minecleannames() {
	rename -n 's/ +/_/g' *
	if [ $? == 0 ]; then
		echo "Rename ? (y/N)";
		read ans;
		if [ "x$ans" == "xy" ] ; then
			rename -v 's/ +/_/g' *
		else
			echo "aborting";
		fi
	fi

	rename -n "s/'/-/g" *
	if [ $? == 0 ]; then
		echo "Rename ? (y/N)";
		read ans;
		if [ "x$ans" == "xy" ] ; then
			rename -v "s/'/-/g" *
		else
			echo "aborting";
		fi
	fi

	rename -n 's/[,(){}&!]/-/g' *
	if [ $? == 0 ]; then
		echo "Rename ? (y/N)";
		read ans;
		if [ "x$ans" == "xy" ] ; then
			rename -v 's/[,(){}&!]/-/g' *
		else
			echo "aborting";
		fi
	fi

	rename -n 's/[!%?\$]//g' *
	if [ $? == 0 ]; then
		echo "Rename ? (y/N)";
		read ans;
		if [ "x$ans" == "xy" ] ; then
			rename -v 's/[!%?\$]//g' *
		else
			echo "aborting";
		fi
	fi
}

k15() {
	pattern=$1;
	psg $pattern;
	if [ $? == 0 ]; then
		echo "kill -15 ? (Y/n)";
		read ans;
		if [ "x$ans" == "xn" ] ; then
			echo "aborting";
		else
			kill -15 `ps aux |grep -i $pattern |grep -v grep |awk '{print $2}'`
		fi
	fi
}

k9() {
	pattern=$1;
	psg $pattern;
	if [ $? == 0 ]; then
		echo "kill -9 ? (y/N)";
		read ans;
		if [ "x$ans" == "xy" ] ; then
			kill -9 `ps aux |grep -i $pattern |grep -v grep |awk '{print $2}'`
		else
			echo "aborting";
		fi
	fi
}

set_title() {
	print -nR $'\033k'$1$'\033'\\
	print -nR $'\033]0;'$1$'\a'
}

ssh() {
	target=$_
	target=${target//*@/}
	set_title $target
	command ssh -t $*
}



#------------------------------------------------------------------------------
# GNU Screen stuff 
#------------------------------------------------------------------------------
function screenwrap() {
	if [ "$1" = "-binonly" ]; then
		cmd=$(basename $2)
		shift 2
		title="$cmd"
	else
		cmd=$(basename $1)
		shift 1
		title="$cmd $@"
	fi
	echo -ne "\033k${title}\033\\"
	$cmd $@
}

if [ $TERM = "screen" ]; then
	alias irssi="screenwrap irssi"
	alias ssh="screenwrap ssh"
	alias lftp="screenwrap lftp"
	alias scp="screenwrap -binonly scp"
	alias mutt='screenwrap mutt'
	alias mc="screenwrap mc"
	alias man="screenwrap man"
	alias alsamixer="screenwrap alsamixer"
	alias top='screenwrap top'
	alias htop='screenwrap htop'

	PROMPT_COMMAND='echo -ne "\033k$(echo -n $PWD | sed s,^$HOME,~,)\033\\"'
fi

case "$TERM" in
	xterm*|rxvt*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
		;;
	*)
	;;
esac





