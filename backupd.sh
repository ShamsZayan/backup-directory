#!/bin/bash

dir="$1"
backupdir="$2"
interval_secs="$3"
max_backups="$4"
ls -lR $dir > directory-info.last
mkdir $backupdir/$(date +"%y-%m-%d-%H-%M-%S") && cp -r $dir/*  $backupdir/$(date +"%y-%m-%d-%H-%M-%S")
while true
do
        sleep $interval_secs
	ls -lR $dir > directory-info.new
	if ! cmp -s  directory-info.new directory-info.last; then
    mkdir $backupdir/$(date +"%y-%m-%d-%T") && cp -r $dir/*  $backupdir/$(date +"%y-%m-%d-%T")
    ls -lR $dir > directory-info.last
        fi
        if [ $(find $backupdir -mindepth 1 -maxdepth 1 -type d | wc -l) -gt $max_backups ]
        then
         array=( $( ls -t -r $backupdir ) )
         rm -r $backupdir/${array[0]}
        fi
 done
