#
# ~/.bashrc
#

# =======================
# ===     Aliases     ===
alias ll='ls --group-directories-first -A'

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
