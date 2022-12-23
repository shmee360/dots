#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\033[01;33m\][\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;31m\]\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[01;33m\]]\[\033[00m\]\$ '

if [ -f $HOME/.config/bash_aliases ]; then
	. $HOME/.config/bash_aliases
fi

tput smkx
