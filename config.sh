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
    ttf-mscorefonts-installer
)

DESIGN=(
    inkscape \
    gimp \
)

DEV=(
    code \
    arduino-cli \
    #psql \
    #pgadmin4 
)





