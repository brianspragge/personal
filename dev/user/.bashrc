#
# ~/.bashrc
#

# Auto-load hyprland at startup for tty1
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec Hyprland

# =======================
# ===     Aliases     ===
alias ls='ls --color=auto --group-directories-first -A'
alias lsc='clear; ls'

# =======================
# ===    Defaults     ===
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# =======================
# ===      Extra      ===
# Bash scripting guide by You Suck at Programming
# curl style.ysap.sh

# =======================
# ===    Functions    ===
if [[ -n "$HISTCONTROL" ]]; then
  export HISTCONTROL="${HISTCONTOL}:ignoredups:erasedups:ignorespace;"
else
  export HISTCONTROL="ignoredups:erasedups:ignorespace"
fi

# =======================
# ===      Paths      ===
export PATH="$HOME/bin:$PATH"

# =======================
# ===    Variables    ===
ENV() { echo "$VIRTUAL_ENV"; }
export GPG_TTY=$(tty)
export EDITOR=vim
#export LESS="-R --use-color -Dd+r -Du+b"
