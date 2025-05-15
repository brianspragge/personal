#
# ~/.bashrc
#

##
# Aliases
alias ll='ls --group-directories-first -A'

##
# Variables
ENV() { echo "$VIRTUAL_ENV"; }
export GPG_TTY=$(tty)

##
# Functions
if [[ -n "$HISTCONTROL" ]]; then
  export HISTCONTROL="${HISTCONTOL}:ignoredups:erasedups:ignorespace;"
else
  export HISTCONTROL="ignoredups:erasedups:ignorespace"
fi

export PATH="$HOME/bin:$PATH"

##
# Defaults
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
