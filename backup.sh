#!/bin/bash

isMounted() { findmnt -rno TARGET "$1" >/dev/null;}
Mount(){
    if ! $( isMounted "$2" ); then
        sudo mkdir "$2"
        sudo mount -L "$1" "$2"
        sleep 1
        return 0
    fi
    return 1
}

Umount(){
    if [[ $1 -eq 0 ]]; then
        sudo umount "$2"
        sudo rmdir "$2"
    fi
}

DRIVE_NAME='Caio Pellicani'
DRIVE=/media/$USER/$DRIVE_NAME

ORIGIN_PATH="$HOME"
BACKUP_PATH=$DRIVE/backup
EX_FOLDER="Downloads"

$( Mount "$DRIVE_NAME" "$DRIVE" )
PREV_MONT=$?

if $( isMounted "$DRIVE" ); then
    if [ $1 == "recovery" ]; then
        echo "Recovery mode can ocassionate data loss, are you sure? [Y/N]"
        read result

        if [ "${result^^}" == "Y" ]; then
            sudo rsync -av --progress --compress "$BACKUP_PATH/" "$ORIGIN_PATH"
        fi
    else
        sudo rsync -av --progress --compress --delete --exclude=$EX_FOLDER  "$ORIGIN_PATH" "$BACKUP_PATH"
    fi
else
    echo "Backup Drive not Mounted"
fi

Umount $PREV_MONT "$DRIVE"


