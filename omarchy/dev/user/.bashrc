# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# If not running interactively, don't do anything else (leave this above the rc source)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source "$OMARCHY_PATH/default/bash/rc"

# Personal
#
# =======================
# ===     Aliases     ===
# alias ls='ls --group-directories-first -ChF'  # Columns
alias cls='clear; ls'
alias clsa='clear; lsa'
alias lt='eza --group-directories-first --tree --level=2 --long --icons --git --ignore-glob=".git|.gitignore|.gitattributes|node_modules|.venv|__pycache__"'
alias clt='clear; lt'
alias clta='clear; lta'
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
# ===      PATH       ===
export PATH="$HOME/.local/bin:$PATH"

# =======================
# ===    Variables    ===
ENV() { echo "$VIRTUAL_ENV"; }
# activate env in current dir
alias SRCENV='source .env/bin/activate; ENV'
export EDITOR=vim
