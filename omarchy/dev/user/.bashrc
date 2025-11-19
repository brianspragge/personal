# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# =======================
# ===     Aliases     ===
# alias ls='ls --color=auto --group-directories-first -A'
alias cls='clear; ls'  # cls = CLEAR;SHOW
alias clsa='clear; lsa'  # cls = CLEAR;SHOW
alias lt='eza --group-directories-first --tree --level=2 --long --icons --git --ignore-glob=".git|.gitignore|.gitattributes|node_modules|.venv|__pycache__"'
alias clt='clear; lt'
alias clta='clear; lta'
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
