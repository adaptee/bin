#!/bin/bash
#===============================================================================
#
#          FILE:  ssh-update.sh
# 
#         USAGE:  ./ssh-update.sh 
# 
#   DESCRIPTION:  updating various config files on remote ssh hosts;should be 
#                 automated by cron(8).
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  adaptee (), adaptee@gmail.com
#       COMPANY:  Open Source Corporation
#       VERSION:  1.0
#       CREATED:  2009年05月17日 21时30分30秒 CST
#      REVISION:  ---
#===============================================================================

config_files=(".profile" ".bashrc" ".inputrc" ".bash.d" ".screenrc" ".ssh/config" ".vimrc" ".vim" )

ssh_hosts=("bsd")

for host in "${ssh_hosts[@]}";do
    echo "host:${host}"
    ssh-copy-id ${USER}@${host}

    for item in "${config_files[@]}" ;do
        scp -C  -r ${HOME}/${item} "${USER}@${host}:"
        echo "[info]: ${item} is transfered to ${USER}@${host}:${item}"
        #scp -C  -r ${HOME}/${item} "${USER}@${host}:${item}"
    done

done










