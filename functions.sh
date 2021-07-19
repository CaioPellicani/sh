#!/bin/sh

installed(){
    isInstalled=$(dpkg-query -l "$1" 2>/dev/null | grep "$1" )
    isInstalled+=$(ls /bin | grep "$1" )
    isInstalled+=$(ls /sbin | grep "$1" )   

    if [[ "${isInstalled}" == "" ]]; then
        return 0
    fi
    return 1
}

printDate(){ printf "\nDATE: %(%d/%h/%Y %T)T\n" $(date +%s) >> $1; }

getStdErr(){
    if [ ! "$(cat /tmp/stream)" == "" ]; then 
        printDate $1
        cat /tmp/stream >> $1
    fi
}

mkLogDir(){ [ ! -d "${LOG_DIR}" ] && mkdir "${LOG_DIR}"; }
mkErrorDir(){  [ ! -d "${ERROR_DIR}" ] && mkdir "${ERROR_DIR}"; }

updateRepo(){
    printf "Updating Repos\n"
    runScript "$UPDATE_CMD" ${LOG_DIR}/"update_log" ${ERROR_DIR}/"update_error"
}

runScript(){
    printDate ${2}
    $1 1>> ${2} 2> /tmp/stream

    getStdErr ${3} 
}

wget_dpkg(){
    wget -O $TEMP_DIR/$1.deb $2
    sudo dpkg -i $TEMP_DIR/$1.deb
}

addConfig(){ CONFIG_LIST[${#CONFIG_LIST[@]}]=$1; }

installPackages(){
    for i in ${PACKAGES[*]}; do
    $( installed $i )
    if [ $? -eq 0 ]; then
        printf "Installing %s\n" ${i}

        FUNC_NAME=$( echo "${i}_install" | tr - _ )
        runScript"${FUNC_NAME}" ${LOG_DIR}/${i}_log ${ERROR_DIR}/${i}_error
    else
        printf "Package already installed: %s\n" $i 
    fi
    done
}

configPackages(){
    for i in ${CONFIG_LIST[*]}; do
        FUNC_NAME=$( echo "${i}_config" | tr - _ )
        ${FUNC_NAME}
    done
}

rebootQuestion(){
    echo "You want a reboot?(Y/N)"
    read result
    [ "${result^^}" == "Y" ] && eval "/sbin/shutdown -r now"
}


