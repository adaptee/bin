#!/bin/bash
#===============================================================================
#
#          FILE:  backup-system-etc.sh
#
#         USAGE:  ./backup-system-etc.sh
#
#   DESCRIPTION:  back important config files under /etc/
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  adaptee (), adaptee@gmail.com
#       COMPANY:  Open Source Corporation
#       VERSION:  1.0
#       CREATED:  2009年12月24日 02时06分16秒 CST
#      REVISION:  ---
#===============================================================================

function better-cp ()
{
    cp -v -a --parents "$1" "$2"
}

#function better-cp ()
#{
    #(( $# == 2 )) || echo "Usage: better-cp source dest_base_dir"

    #local source_item=$1
    #local dest_base_dir=$2

    #local dest_item="${dest_base_dir}/${source_item}"
    #local parent_dir=$( dirname ${dest_item} )

    ## create all necessary intermediate directories
    #[[ -d "${parent_dir}" ]] || mkdir -p "${parent_dir}"

    ## deal with both file and folder; preseving timestamp
    #cp -p -r -v "${source_item}" "${dest_item}"
#}

Base_Dest_Dir=~/bin/os-install/arch
System_Dest_Dir=${Base_Dest_Dir}/system
SSH_Dest_Dir=${Base_Dest_Dir}/personal

mkdir -p "${Base_Dest_Dir}"
mkdir -p "${System_Dest_Dir}"
mkdir -p "${SSH_Dest_Dir}"


System_Etc_List=( '/etc/hosts'
           '/etc/hosts.allow'
           '/etc/locale.nopurge'
           '/etc/resolv.conf'
           '/etc/rc.conf'
           '/etc/fstab'
           '/etc/sysctl.conf'
           '/etc/makepkg.conf'
           '/etc/wicd/manager-settings.conf'
           '/etc/wicd/wireless-settings.conf'
           '/etc/sudoers'
           '/etc/samba/smb.conf'
           '/etc/nsswitch.conf'
           '/etc/X11/xorg.conf'
           '/etc/udev/rules.d/01-touchpad.rules'
           '/etc/hal/fdi/policy/11-x11-synaptics.fdi'
           '/etc/pacman.d/mirrorlist'
           '/etc/pacman.conf'
           '/etc/cron.daily/pacman'
           '/etc/cron.daily/localepurge'
           '/boot/grub/menu.lst'
           '/usr/share/config/kdm/kdmrc'
           '/usr/share/locale/zh_CN/LC_MESSAGES/wget.mo'
           # '/var/spool/cron/crontabs/whodare'
         )

SSH_Keys=( "./.ssh/id_rsa"
           "./.ssh/id_rsa.pub"
           "./.ssh/known_hosts"
           "./.ssh/config"
         )

# this is very important
cd ~

# clear old backup
#[[ -n ${System_Dest_Dir} ]] && rm ${System_Dest_Dir}/* -rf
#[[ -n ${SSH_Dest_Dir} ]]    && rm ${SSH_Dest_Dir}/* -rf

# backup system wide configuration
for item in ${System_Etc_List[@]}; do
    better-cp "${item}" "${System_Dest_Dir}"
done

# backup user wide configuration
for item in ${SSH_Keys[@]}; do
    better-cp ${item} "${SSH_Dest_Dir}"
done
