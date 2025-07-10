#
# ~/.bashrc
#

# Change style/color of bash prompt.  Must enable vi mode in inputrc.
# https://superuser.com/questions/1466222/move-vi-mode-string-to-end-of-bash-prompt
EMBEDDED_PS1='[\w]\$'
reset_readline_prompt_mode_strings () {
    bind "set vi-cmd-mode-string \"\1\e[32m\2${EMBEDDED_PS1@P}:\1\e[92m\2\1\e[0m\2\""
    bind "set vi-ins-mode-string \"\1\e[0m\2${EMBEDDED_PS1@P} \1\e[94m\2\1\e[0m\2\""
}
PROMPT_COMMAND=reset_readline_prompt_mode_strings
PS1=''

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
