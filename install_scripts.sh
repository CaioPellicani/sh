#!bin/bash

source ${PROJ_DIR}/config.sh
source ${PROJ_DIR}/functions.sh

git_install(){  $INSTALL_CMD git; addConfig git; }
gdb_install(){  $INSTALL_CMD gdb; }
valgrind_install(){  $INSTALL_CMD valgrind; }
htop_install(){ $INSTALL_CMD htop; }
ttf_mscorefonts_installer(){ $INSTALL_CMD ttf-mscorefonts-installer; }
numlockx_installer(){ $INSTALL_CMD numlockx; addConfig numlockx; }
gparted_install(){  $INSTALL_CMD gparted; }

brave_install(){ git 
    $INSTALL_CMD apt-transport-https curl gnupg
    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    $INSTALL_CMD brave-browser
}

google_chrome_stable_install(){
    wget_dpkg chrome https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
}

teams_isntall(){
    wget_dpkg teams https://go.microsoft.com/fwlink/p/?LinkID=2112886&clcid=0x416&culture=pt-br&country=BR
}

inkscape_install(){ $INSTALL_CMD inkscape; }
gimp_install(){ $INSTALL_CMD gimp; }

code_install(){
    wget_dpkg code https://go.microsoft.com/fwlink/?LinkID=760868
    addConfig code
}

arduino_cli_install(){
    curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
    sudo mv ./bin/arduino-cli /bin/arduino-cli
    rmdir ./bin
}
