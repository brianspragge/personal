# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# =======================
# ===     Aliases     ===
# alias ls='ls --color=auto --group-directories-first -A'
alias cls='clear; ls'  # cls = CLEAR;SHOW
alias clsa='clear; lsa'  # cls = CLEAR;SHOW

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
