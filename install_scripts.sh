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
timeshift_install(){  $INSTALL_CMD timeshift; }
neofetch_install(){  $INSTALL_CMD neofetch; }
flameshot(){  $INSTALL_CMD flameshot; }

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

postgresql_install(){
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

    sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
    sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'

    $UPDATE_CMD update
    $INSTALL_CMD postgresql pgadmin4-web 
    addConfig postgresql;
}

virtualbox_install(){
	wget https://www.virtualbox.org/download/oracle_vbox_2016.asc
	sudo apt-key add oracle_vbox_2016.asc

	sudo echo "deb http://download.virtualbox.org/virtualbox/debian buster contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

	$UPDATE_CMD update
	$INSTALL_CMD virtualbox-6.1
}

docker_install(){
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	$UPDATE_CMD update
    $INSTALL_CMD docker-ce docker-ce-cli containerd.io
}