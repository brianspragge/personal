#
# ~/.bashrc
#
# Environment setup also applies to non-interactive shells.
export PATH="$HOME/.env/bin:$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
elif [ -s /usr/share/nvm/init-nvm.sh ]; then
  . /usr/share/nvm/init-nvm.sh
fi
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# If not running interactively, don't do anything else.
[[ $- != *i* ]] && return

# =======================
# ===     Aliases     ===
# TODO(bms): convert all aliases into functions?  Reason being, functions are prefered, and are looked up before
#            aliases.  There are also other issues with aliases, such as expanding when read and not affecting
#            commands on proceeding lines.
alias BRIANS_PWD='printf " ○ %s: \n" "$PWD"'
alias mycal='cal; catimg -H 31 ~/Pictures/Macbaconai-floating-oriental-roofing-island.jpeg'
alias mycow="cowsay -f /usr/share/cowsay/cows/mutilated.cow \"Hey!  It's Brian...a little help here?\""
mycal
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
alias lt='eza --group-directories-first --tree --level=2 --long --icons --git --ignore-glob=".git|.gitignore|.gitattributes|node_modules|__pycache__"'
# alias lt='eza --group-directories-first --tree --level=2 --long --icons --git --ignore-glob=".git|.gitignore|.gitattributes|node_modules|.venv|__pycache__"'
alias lta='lt -a'
alias clt='clear; lt'
alias clta='clear; lta'
# Viewing images through terminal through <imv> without blur by default
alias imv='imv -u nearest_neighbour'

# =======================
# ===    Functions    ===
# <history> becomes very neat, thanks to SOandSO.
if [[ -n "$HISTCONTROL" ]]; then
  export HISTCONTROL="${HISTCONTROL}:ignoredups:erasedups:ignorespace"
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
# =======================
# ===    Processes    ===
# Safety: make sure pacman pkg runs in other terminals
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# =======================
# ===    Variables    ===
ENV() { echo "$VIRTUAL_ENV"; }
# activate env in current dir
alias SRCENV='source .env/bin/activate; ENV'
export GPG_TTY=$(tty)
export EDITOR=vim
#export LESS="-R --use-color -Dd+r -Du+b"
