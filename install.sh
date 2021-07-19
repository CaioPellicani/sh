#!/bin/bash
PROJ_DIR=$(dirname "$0")
CONFIG_LIST=(swappiness)

source ${PROJ_DIR}/functions.sh
source ${PROJ_DIR}/config.sh
source ${PROJ_DIR}/install_scripts.sh
source ${PROJ_DIR}/config_scripts.sh

mkLogDir
mkErrorDir

PACKAGES=( teste )
PACKAGES=( ${PACKAGES[@]} ${BASIC[@]} ${DEV[@]} ${DESIGN[@]} )

#updateRepo
installPackages
configPackages
#rebootQuestion