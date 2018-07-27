# Path to your oh-my-zsh installation.
export ZSH=/home/varun/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

setopt complete_aliases

alias cl="clear"
alias susu="sudo aptitude update && sudo aptitude upgrade"
alias cp="rsync -av --progress"
alias apti="aptitude"
alias lynx="lynx -vikeys"
alias info="info --vi-keys"
alias xo="xdg-open"
alias rmr="rm -R"
alias rmrf="rm -Rf"
alias juno="jupyter notebook"
# for expansion with sudo commands
alias sudo="sudo "
eval "$(thefuck --alias shit)"
alias sapi="sudo aptitude install "
alias getwifi="sudo systemctl restart network-manager.service"
alias ocb="ocamlbuild "
alias cclip="xclip -selection clipboard"
alias stackdel="stack exec ghc-pkg unregister "
alias cabalconf="cabal configure --package-db=clear --package-db=global --package-db=$(stack path --snapshot-pkg-db) --package-db=$(stack path --local-pkg-db) --with-compiler=$(stack path --compiler-exe)"
alias xilink="xi-runtime/runtime/linkxi.sh"
alias vi="nvim"
alias scabal="stack exec cabal --"

function mkcd(){
	mkdir $@ && cd $1
}

function vh(){
	$@ --help | less -R
}

function trls(){
	tree $@ | less
}

function getstr(){
	grep -rn . --exclude-dir="__pycache__" --exclude-dir=".stack-work" -e $@
}

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking

# Completions for rustup
fpath+=~/.zfunc

# OPAM configuration
. /home/varun/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
