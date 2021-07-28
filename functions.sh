#!/bin/sh

installed(){ local package=$1
    isInstalled=$(dpkg-query -l "$package" 2>/dev/null | grep "$package" )
    isInstalled+=$(ls /bin | grep "$package" )
    isInstalled+=$(ls /sbin | grep "$package" )   

    if [[ "${isInstalled}" == "" ]]; then
        return 0
    fi
    return 1
}

printDate(){ printf "\nDATE: %(%d/%h/%Y %T)T\n" $(date +%s) >> $1; }

getStdErr(){ local errDir=$1
    if [ ! "$(cat /tmp/stream)" == "" ]; then 
        printDate $errDir
        cat /tmp/stream >> $errDir
    fi
}

mkLogDir(){ [ ! -d "${LOG_DIR}" ] && mkdir "${LOG_DIR}"; }
mkErrorDir(){  [ ! -d "${ERROR_DIR}" ] && mkdir "${ERROR_DIR}"; }

updateRepo(){
    printf "Updating Repos\n"
    runScript "$UPDATE_CMD" ${LOG_DIR}/"update_log" ${ERROR_DIR}/"update_error"
}

runScript(){ local script=$1; local outDir=$2; local errDir=$3
    printDate ${outDir}
    $script 1>> ${outDir} 2> /tmp/stream

    getStdErr ${errDir} 
}

wget_dpkg(){ local package=$1; local url=$2
    wget -O $TEMP_DIR/$package.deb $url
    sudo dpkg -i $TEMP_DIR/$package.deb
}

addConfig(){ local package=$1
    CONFIG_LIST[${#CONFIG_LIST[@]}]=$package; 
}

installPackages(){
    for i in ${PACKAGES[*]}; do
    $( installed $i )
    if [ $? -eq 0 ]; then
        printf "Installing %s\n" ${i}

        FUNC_NAME=$( echo "${i}_install" | tr - _ )
        runScript "${FUNC_NAME}" ${LOG_DIR}/${i}_log ${ERROR_DIR}/${i}_error
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


