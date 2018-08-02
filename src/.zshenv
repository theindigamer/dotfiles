setopt complete_aliases

# Frequently used aliases
alias cp="rsync -av --progress"
alias xo="xdg-open"
alias rmr="rm -R"
alias rmrf="rm -Rf"
alias vi="nvim"
alias sudo="sudo " # for expansion with sudo commands
alias susu="sudo aptitude upgrade && sudo aptitude upgrade"

alias lynx="lynx -vikeys"
alias info="info --vi-keys"

function mkcd() {
    mkdir "$@" && cd "$1"
}

function vh() {
    if [ "$1" = "stack" ]; then
        "$@" --help | less -R
    else
        man "$@" || ("$@" --help | less -R) || ("$@" -h | less -R)
    fi
}

function trls() {
    tree "$@" | less
}

# Less colors for man pages
export LESS_TERMCAP_mb=$'\e[01;31m'

# for Haskell (Stack), Cabal and Rust (cargo)
export PATH="$HOME/.local/bin:$HOME/.cabal/bin:$HOME/.cargo/bin:$PATH"

# OPAM configuration
. /home/varun/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
