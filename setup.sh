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

# Setup keyboard
sudo sed --in-place 's/XKBOPTIONS=""/XKBOPTIONS="ctrl:swapcaps"/' /etc/default/keyboard
setxkbmap -option "ctrl:swapcaps"

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

#------------------------------------------------------------------------------
#- Basic packages

installIfAbsent "aptitude" "sudo apt install -y aptitude"
aptInstallIfFail "man -w set" "manpages-posix-dev"

aptInstallIfAbsent "curl"
aptInstallIfAbsent "tree"
aptInstallIfAbsent "git"
aptInstallIfAbsent "zsh"
aptInstallIfAbsent "tmux"
aptInstallIfAbsent "nvim" "neovim"
aptInstallIfAbsent "emacs" "emacs"
aptInstallIfAbsent "convert" "imagemagick"
aptInstallIfAbsent "rst2pdf"

aptInstallIfAbsent "vlc"
aptInstallIfAbsent "keepass2"
aptInstallIfAbsent "gnome-tweaks" "gnome-tweak-tool"
aptInstallIfAbsent "baobab" # disk usage analyser
# dropbox may notify that it needs python-gpgme; this is a known bug.
# python-gpgme is obsolete and has been replaced by python-gpg
# https://askubuntu.com/questions/587249/how-to-install-python-gpgme-ubuntu-14-04
# Dropbox still needs to be manually setup and started
aptInstallIfAbsent "dropbox" "nautilus-dropbox python-gpg"
ZOTERO_PPA="ppa:smathot/cogscinl"
ZOTERO_PPA_ADD="sudo add-apt-repository --yes --update $ZOTERO_PPA"
installIfAbsent "zotero" "$ZOTERO_PPA_ADD && $APT_INSTALL zotero-standalone"

#------------------------------------------------------------------------------
#- Languages and related stuff

aptInstallIfAbsent "shellcheck"
aptInstallIfAbsent "python3" "python3-dev"
aptInstallIfAbsent "pip3" "python3-pip"

STACK_INSTALL="wget -qO - https://get.haskellstack.org/ | sh"
RUST_INSTALL="curl -sSf https://sh.rustup.rs | sh -s - -y"

installIfAbsent "stack"  "$STACK_INSTALL"
installIfAbsent "rustup" "$RUST_INSTALL"
# opam suggests install m4
aptInstallIfAbsent "opam"
installIfAbsent "rg"     "cargo install ripgrep"
installIfAbsent "thefuck" "pip3 install thefuck"

#------------------------------------------------------------------------------
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

getGitRepo ~/.emacs.d https://github.com/syl20bnr/spacemacs

getGitRepo ~/.tmux/plugins/tpm https://github.com/tmux-plugins/tpm

getGitRepo dotfiles https://github.com/theindigamer/dotfiles.git
rsync -a dotfiles/src/ ~
)

#------------------------------------------------------------------------------
#- Fonts

aptInstallIfFail "fc-list | grep Powerline > /dev/null" "fonts-powerline"

(
mkdir -p .fonts
cd .fonts || WAT "Couldn't cd into ~/.fonts"
IOSEVKA_VERSION="2.0.0"
IOSEVKA_ZIP="iosevka-ss09-$IOSEVKA_VERSION.zip"
IOSEVKA_REPO="https://github.com/be5invis/Iosevka"
IOSEVKA_URL="$IOSEVKA_REPO/releases/download/v$IOSEVKA_VERSION/$IOSEVKA_ZIP"
IOSEVKA_DOWNLOAD="wget -q $IOSEVKA_URL"
if [ ! -f "$IOSEVKA_ZIP" ]; then
    eval "$IOSEVKA_DOWNLOAD"
    unzip "$IOSEVKA_ZIP"
    sudo fc-cache .
fi
)

#------------------------------------------------------------------------------
#- Oh My Zsh!
#- Install it last because it changes the shell by default :|

OH_MY_ZSH_INSTALL="sh -c \"\$(wget -q https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)\""
installIfAbsent "upgrade_oh_my_zsh" "$OH_MY_ZSH_INSTALL"

#------------------------------------------------------------------------------
#- Final reminder messages

echo "---                                                                  ---"
echo "Don't forget to install the following stuff manually:"
echo "  Firefox - Vimium, Privacy Badger, uBlock origin"
echo "          - Yomichan, Stylus, Emoji cheatsheet, Reddit Enhancement Suite"
echo "          - Zotero connector"