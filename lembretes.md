### saida de erro 
    exemplo >2 >>2
### saida nula 
    /dev/null

### voltar dir 
    cd -
---
### desligar teclado:
    xinput list
    "indentificar id do dispositivo "AT Translated Set 2 keyboard"
    xinput float "id identificado" exemplo:
        xinput float 15 


### Deixar terminal bonitinho

    PS1='\[\e[1;32m\]\342\224\214\342\224\200\[\e[1;32m\][\[\e[1;34m\]\u\[\e[1;32m\]@\[\e[1;34m\]\h\[\e[1;32m\]]\[\e[1;32m\]\342\224\200\[\e[1;32m\][\[\e[1;34m\]\w\[\e[1;32m\]]\[\e[1;32m\]\342\224\200[\[\e[1;34m\]\t\[\e[1;32m\]]\n\[\e[1;32m\]\342\224\224\342\224\200\342\224\200\342\225\274\[\e[1;32m\] \$ \[\e[0m\]'

### Programa de rec de disco

    testdisk

### apache / systemd
    sudo systemctl disable apache2
    sudo update-rc.d apache2 disable
    sudo update-rc.d apache2 enable

    sudo service apache2 start
    sudo service apache2 stop

---
## DOCKER
### -t para dar o nome my-php-app
    sudo docker build -t image_name ./docker

### porta 500 do host p 80 do container
    sudo docker run -p 500:80 image_name --name container_name

### Conecta o dir do host c/ o dir do container
    sudo docker run --name container_name -p 500:80 -v ~/Documentos/FATEC/WEB/docker/php:/var/www/html/ image_name 

### Comandos basidos
    sudo docker start container_name
    sudo docker stop container_name
    sudo docker ps -a //lista todos os containers
    sudo docker images //lista as imagens
--- 