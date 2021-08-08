#!/bin/sh

LOG_DIR=${PROJ_DIR}/logs
ERROR_DIR=${PROJ_DIR}/error
TEMP_DIR=$(mktemp -d)

SWAP=10
PKG_MAN="apt-get"
INSTALL_CMD="sudo $PKG_MAN install -y"
UPDATE_CMD="sudo $PKG_MAN update"

BASIC=(
    git \
    htop \
    numlockx \
    brave-browser \
    google-chrome-stable \
    ttf-mscorefonts-installer \
    teams \
    gparted \
    timeshift \
    neofetch \
)

DESIGN=(
    inkscape \
    gimp \
)

DEV=(
    gdb \
    valgrind \
    code \
    arduino-cli \
    postgresql \
    virtualbox \
    docker \
)





