#!/bin/bash
#===============================================================================
#
#          FILE:  gnome-backup.sh
# 
#         USAGE:  ./gnome-backup.sh 
# 
#   DESCRIPTION:  Bakcup/Restrore your Gnome setting in one command
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  adaptee (), adaptee@gmail.com
#       COMPANY:  Open Source Corporation
#       VERSION:  1.0
#       CREATED:  2009年05月02日 17时01分22秒 CST
#      REVISION:  ---
#===============================================================================

usage()
{
    echo "The invocation format should be: $(basename $0) [user-name] [backup-filename]"

}

argc=$#

echo ${argc}

#case ${argc} in
    #0)
    #usage
    #;;

    #1)
    #;;

    #*)
    #usage
    #;;

#esac    # --- end of case ---

# check whether the array contains specified element
array_has_element()
{
    #echo "in array_has_element()"

    local received_array      # Local variable!
    received_array=( `echo "$1"` )
    #echo "received_array:${received_array[@]}"
    
    local element=$2;
    local item=''

    for item in "${received_array[@]}"; do
        #echo "${item}:${element}"
        if [ ${element} = ${item}  ];then
            echo "${element} exist in array"
            return 0
        fi
    done
    
    #echo "$element don't exist in array"
    return 1
}

should_ignore()
{

    local item=$1
    local first_char=${item:0:1}
    echo "first_char:${first_char}"    

    if [ ${first_char} != "." ] ; then
        return 0
    fi

    local exclude_items=(.chmsee .dropbox .thumbnails .Trash  .nautilus . .. ) 
    array_argument=`echo ${exclude_items[@]}`;
    
    if array_has_element  "${array_argument}"  ${item} ;then
        return 0
    else
        return 1
    fi
}

tar_name='gnome-setting-backup.tar.gz'
who=${USER}
additional_items=("${who}/bin" "/etc/fstab" "/etc/samba/smb.conf" "/etc/apt/sources.list" "/boot/grub/menu.lst" "/var/spool/cron/crontab/whodare" )
tmp_dir="/var/tmp/gnome-backup-$$"

tar_location=$HOME

# First,chage pwd to home directory
eval builtin cd ~${who}
echo ${PWD}

# Note, here '-A' is used to ignonre '.' and '..'
items=$(ls -A)

mkdir -p ${tmp_dir} 

# Backup hidden config folders/files
for item in ${items} ;do

    # some items should be ignore
    if should_ignore ${item} ;then
        echo "${item} should not be processed! "
        continue
    fi

    # Now we copy the item to a temperorary location
    echo "${item} should be processed"
    #echo "cp -v -r ./${item}  ${tmp_dir}/"
    cp -v -r ./${item}  ${tmp_dir}/
done

# except the hidden config folders/files, some others items should also be backuped
for item  in "${additional_items[@]}" ; do
    cp -v -r ${item}  ${tmp_dir}/
done

builtin cd ${tmp_dir}

# Note, here '-A' is used to ignonre '.' and '..'
tar czpfv ../${tar_name} `ls -A`  

#mv ../${tar_name}  ${tar_location}/  

(cd ; rm -rf ${tmp_dir})

echo "Congratulation! Your Gnome setting have been succefully save into ${tar_location}/${tar_name}"

#eval tar -xzvvf ${tar_name} -C ~/${who}

