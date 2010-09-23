#!/bin/bash
#===============================================================================
#
#          FILE:  backup-system.sh
#
#         USAGE:  ./backup-system.sh
#
#   DESCRIPTION:
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  adaptee (), adaptee@gmail.com
#       COMPANY:  Open Source Corporation
#       VERSION:  1.0
#       CREATED:  2010年02月28日 23时41分42秒 CST
#      REVISION:  ---
#===============================================================================

tar -cvf - / --exclude=/tmp/* --exclude=/dev/* --exclude=/lost+found/* \
--exclude=/proc/* --exclude=/sys/* --exclude=/cdrom/* --exclude=/media/* \
--exclude=/mnt/* --exclude=/var/run/* --exclude=/var/lock/* | gzip -c -1 | ssh whodare@192.168.1.37 cat ">" "~/Desktop/gentoo.gz"
