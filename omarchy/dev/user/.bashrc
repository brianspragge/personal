# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# =======================
# ===     Aliases     ===
alias BRIANS_PWD='printf " ○ %s: \n" "$PWD"'
alias ls='ls --group-directories-first -ChF'  # Columns
alias cls='clear; BRIANS_PWD; ls'
alias clsa='clear; BRIANS_PWD; lsa'
alias ll='ls -l'  # Single list
alias lla='ll -A'
alias cll='clear; BRIANS_PWD; ll'
alias clla='clear; BRIANS_PWD; lla'
alias lt='eza --group-directories-first --tree --level=2 --long --icons --git --ignore-glob=".git|.gitignore|.gitattributes|node_modules|.venv|__pycache__"'
alias clt='clear; BRIANS_PWD; lt'
alias clta='clear; BRIANS_PWD; lta'
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
