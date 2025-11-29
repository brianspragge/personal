#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# =======================
# ===     Aliases     ===
alias ls='ls --color=auto --group-directories-first -ChF'
alias lsa='ls -A'
alias cls='clear; ls'
alias clsa='clear; lsa'
alias ll='ls -l'
alias lla='ll -A'
alias cll='clear; ll'
alias clla='clear; lla'
# Viewing images through terminal through <imv> without blur by default
alias imv='imv -u nearest_neighbour'

# =======================
# ===    Functions    ===
# <history> becomes very neat, thanks to SOandSO.
if [[ -n "$HISTCONTROL" ]]; then
  export HISTCONTROL="${HISTCONTOL}:ignoredups:erasedups:ignorespace;"
else
  export HISTCONTROL="ignoredups:erasedups:ignorespace"
fi

# =======================
# ===      Paths      ===
# ~/bin for python ENV
# ~/.local/bin for personal bash scripts
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# =======================
# ===    Processes    ===
# Safety: make sure pacman pkg runs in other terminals
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# =======================
# ===    Variables    ===
ENV() { echo "$VIRTUAL_ENV"; }
export GPG_TTY=$(tty)
export EDITOR=vim
