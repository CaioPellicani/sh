#!bin/bash

git_config(){
    echo "git config global name:"
    read result
    git config --global user.name "$result"
    echo "git config global email:"
    read result
    git config --global user.email "$result"
}

code_config(){
    base="code --install-extension"

    ${base} ms-ceintl.vscode-language-pack-pt-br
    ${base} ms-vscode.cpptools
    ${base} ms-vscode.cmake-tools
    ${base} coenraads.bracket-pair-colorizer-2
}

numlockx_config(){
    file=slick-greeter.conf
    if [ "$( sudo ls /etc/lightdm | grep $file )" == "" ]; then
        printf "[Greeter]\nactivate-numlock=true" > $file 
        sudo mv $file /etc/lightdm/$file -f
    fi
}

swappiness_config(){
    SWAP=10
    if [ ! "$(sudo sysctl vm.swappiness)" == "vm.swappiness = $SWAP" ]; then
        echo "vm.swappiness=$SWAP" > swap.conf
        sudo mv ./swap.conf /etc/sysctl.d/swap.conf
        sudo sysctl -p /etc/sysctl.conf
        sudo sysctl vm.swappiness=$SWAP
    fi
}
