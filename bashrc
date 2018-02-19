#
# ~/.bashrc
#

set -o vi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

alias l='ls'
alias k='ls'
alias lk='ls'
alias ll='ls -alh'
alias ls='ls --color=auto'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias t="touch"
alias r="rm -Iv"

# create a directory and enter it
mkcd(){
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

# open new terminal with same pwd
clone(){
	DIR=`pwd`
	nohup urxvt -cd "$DIR" &>/dev/null &
	disown
}
alias cln="clone"

# pipe yaourt search through colorized less
search(){
	yaourt -Ss --color $@ | less -r
}
alias install="yaourt -S"
alias uninstall="yaourt -Rns"

#export PS1="\[$(tput setaf 1)\]┌╼ \[$(tput bold)\]\[$(tput setaf 2)\][\w]\n\[$(tput setaf 1)\]\$(if [[ \$? == 0 ]]; then echo \"\[$(tput setaf 1)\]└─╼\"; else echo \"\[$(tput setaf 1)\]└─╼\"; fi) \[$(tput setaf 7)\]\[$(tput sgr0)\]"
export PS1="\[$(tput setaf 1)\]┌╼ \[$(tput bold)\]\[$(tput setaf 2)\][\w]\n\[$(tput setaf 1)\]\$(if [[ \$? == 0 ]]; then echo \"\[$(tput setaf 1)\]╼\"; else echo \"\[$(tput setaf 1)\]╼\"; fi) \[$(tput setaf 7)\]\[$(tput sgr0)\]"
