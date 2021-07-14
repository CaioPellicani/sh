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

$( Mount "$DRIVE_NAME" "$DRIVE" )
PREV_MONT=$?

if $( isMounted "$DRIVE" ); then
        sudo rsync -av --progress --compress --delete \
        --exclude=Downloads --exclude=.cache --exclude=.local/share/tracker \
        --exclude=.local/share/Trash \
        "$ORIGIN_PATH" "$BACKUP_PATH"
else
    echo "Backup Drive not Mounted"
fi

Umount $PREV_MONT "$DRIVE"


