#!/bin/bash
#===============================================================================
#
#          FILE:  package-size.sh
#
#         USAGE:  ./package-size.sh
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
#       CREATED:  2010年03月25日 14时36分00秒 CST
#      REVISION:  ---
#===============================================================================

# '-q' means show name only, without version number
package_lists=$(pacman -Qq)

for package in $(echo ${package_lists}) ; do

    # convert the size unit to MB, and limit the precision to 0.1
    package_size=$( LANG=en pacman  -Qi ${package} | grep -i "Installed Size" | awk '{printf "%.1f M", $4/1000 }')

    echo -e "${package}\t${package_size}"

done

