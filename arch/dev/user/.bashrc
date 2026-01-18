#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# =======================
# ===     Aliases     ===
alias BRIANS_PWD='printf " ○ %s: \n" "$PWD"'
# Many Columns
alias ls='ls --color=auto --group-directories-first -ChF'
alias lsa='ls -A'
alias cls='clear; BRIANS_PWD; ls'
alias clsa='clear; BRIANS_PWD; lsa'
# Single Column Verbose
alias ll='ls --color=auto -lFh'
alias lla='ll -A'
alias cll='clear; BRIANS_PWD; ll'
alias clla='clear; BRIANS_PWD; lla'
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
#
# Change style/color of bash prompt.  Must enable vi mode in inputrc.
# https://superuser.com/questions/1466222/move-vi-mode-string-to-end-of-bash-prompt
EMBEDDED_PS1='[\w]\$'
reset_readline_prompt_mode_strings () {
    bind "set vi-cmd-mode-string \"\1\e[32m\2${EMBEDDED_PS1@P}:\1\e[92m\2\1\e[0m\2\""
    bind "set vi-ins-mode-string \"\1\e[0m\2${EMBEDDED_PS1@P} \1\e[94m\2\1\e[0m\2\""
}
PROMPT_COMMAND=reset_readline_prompt_mode_strings
PS1=' '

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
#export LESS="-R --use-color -Dd+r -Du+b"
