#!/bin/bash

isMounted() {
    local _DRIVE_PATH="$1"    
    findmnt -rno TARGET "$_DRIVE_PATH" >/dev/null;
}

Mount(){
    local _DRIVE_NAME="$1"
    local _DRIVE_PATH="$2"
    if ! $( isMounted "$_DRIVE_PATH" ); then
        sudo mkdir "$_DRIVE_PATH"
        sudo mount -L "$_DRIVE_NAME" "$_DRIVE_PATH"
        return 1
    fi
    return 0
}

Umount(){
    local _WAS_MOUNT=$1
    local _DRIVE_PATH="$2"   
    if [[ $_WAS_MOUNT -eq 0 ]]; then
        sudo umount "$_DRIVE_PATH"
        sudo rmdir "$_DRIVE_PATH"
    fi
}

DRIVE_NAME='Caio Pellicani'
DRIVE_PATH=/media/$USER/"$DRIVE_NAME"

ORIGIN_PATH="$HOME"
BACKUP_PATH=$DRIVE_PATH/backup

$( Mount "$DRIVE_NAME" "$DRIVE_PATH" )
WAS_MOUNT=$? # the return of the func Mount

if $( isMounted "$DRIVE_PATH" ); then
        sudo rsync -a \
        --progress \
        --compress \
        --delete \
        --exclude=Downloads \
        --exclude=.cache \
        --exclude=cache \
        --exclude=Cache \
        --exclude=CacheStorage \
        --exclude=Temp \
        --exclude=temp \
        --exclude=tracker \
        --exclude=Trash \
        "$ORIGIN_PATH" "$BACKUP_PATH"
else
    echo "Backup Drive not Mounted"
fi

Umount $WAS_MOUNT "$DRIVE_PATH"


