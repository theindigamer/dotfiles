#!/usr/bin/env bash
#
# 0. The script MUST be idempotent. Very little work should be done in the
#    second run if the first run exited successfully.
# 1. I suppose using eval is okay here as there is no user input.

function WAT() {
    echo "$1 WAT."
    exit 1
}

cd ~ || WAT "Can't cd into home directory."

function installIfFail() {
    eval "$1" > /dev/null || eval "$2"
}

function installIfAbsent() {
    installIfFail "command -v \"$1\"" "$2"
}

APT_INSTALL="sudo aptitude install --assume-yes"

function aptInstallIfFail() {
    if [ "$2" != "" ]; then
        PKG="$2"
    else
        echo "Expected 2nd argument to be pkg-name :("
	      exit 1
    fi
    installIfFail "$1" "$APT_INSTALL $PKG"
}

function aptInstallIfAbsent() {
    local PKG="$1"
    if [ "$2" != "" ]; then
        PKG="$2"
    fi
    installIfAbsent "$1" "$APT_INSTALL $PKG"
}

function aptInstallPkgIfAbsent() {
    aptInstallIfFail "dpkg -s \"$1\" > /dev/null" "$1"
}

#-------------------------------------------------------------------------------
#- Essentials

installIfAbsent "aptitude" "sudo apt install -y aptitude"
aptInstallIfFail "man -w set" "manpages-posix-dev"

aptInstallIfAbsent "curl"
aptInstallIfAbsent "tree"
aptInstallIfAbsent "git"
aptInstallIfAbsent "zsh"
aptInstallIfAbsent "convert" "imagemagick"

#-------------------------------------------------------------------------------
#- Languages and related stuff

aptInstallIfAbsent "shellcheck"
aptInstallIfAbsent "python3" "python3-dev"
aptInstallIfAbsent "pip3" "python3-pip"

STACK_INSTALL="wget -qO - https://get.haskellstack.org/ | sh"
RUST_INSTALL="curl -sSf https://sh.rustup.rs | sh -s - -y"

installIfAbsent "stack"  "$STACK_INSTALL"
installIfAbsent "rustup" "$RUST_INSTALL"
installIfAbsent "opam" "$APT_INSTALL m4 aspcud opam"
installIfAbsent "rg"     "cargo install ripgrep"
installIfAbsent "thefuck" "pip3 install thefuck"

#-------------------------------------------------------------------------------
# Editors and plugins

aptInstallIfAbsent "nvim" "neovim"

#-------------------------------------------------------------------------------
#- Stuff available only via git repos

function getGitRepo() {
    if [ -d "$1" ]; then
        if [ -d "$1/.git" ]; then
            pushd "$1"
            git pull -q origin master
            popd
        else
            rm -rf "$1"
            git clone "$2" "$1"
        fi
    else
        git clone "$2" "$1"
    fi
}

(
mkdir -p Code
cd Code || WAT "Couldn't cd into ~/Code."

getGitRepo dotfiles https://github.com/theindigamer/dotfiles.git
for DOTFILE_RELPATH in dotfiles/src/.*; do
    if [[ -d "$DOTFILE_RELPATH" ]]; then
        continue
    fi
    DOTFILE_NAME="$(basename "$DOTFILE_RELPATH")"
    DOTFILE_ABSPATH="$PWD/$DOTFILE_RELPATH"
    DOTFILE_LINKPATH="$HOME/$DOTFILE_NAME"
    if [ -L "$DOTFILE_LINKPATH" ]; then
        if [ "$(readlink -f "$DOTFILE_LINKPATH")" == "$DOTFILE_ABSPATH" ]; then
	    continue
	else
            echo "$DOTFILE_LINKPATH is a symlink but it points to the wrong place."
	    echo "  Fix: Replacing it with a symlink to the right place."
	    rm "$DOTFILE_LINKPATH"
	fi
    elif [ -f "$DOTFILE_LINKPATH" ]; then
        echo "Found $DOTFILE_LINKPATH as an ordinary file."
	echo "  Fix: Replacing it with a symlink."
        rm "$DOTFILE_LINKPATH"
    elif [ -e "$DOTFILE_LINKPATH" ]; then
	echo "$DOTFILE_LINKPATH has some strange file-type ..."
	echo -n "  Output of 'file': "
	file "$DOTFILE_LINKPATH"
	echo "Unsure what to do here ... exiting!"
	exit 1
    fi
    ln -s -T "$DOTFILE_ABSPATH" "$DOTFILE_LINKPATH"
done
)

#------------------------------------------------------------------------------
#- Oh My Zsh!
#- Install it last because it changes the shell by default :|

OH_MY_ZSH_INSTALL="sh -c \"\$(wget -q https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)\""
installIfAbsent "upgrade_oh_my_zsh" "$OH_MY_ZSH_INSTALL"
