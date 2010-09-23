#!/bin/bash
#===============================================================================
#
#          FILE:
#
#         USAGE:
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
#       CREATED:  06/05/10 22:04:24 CST
#      REVISION:  ---
#===============================================================================

statsfile="$HOME/.aMule/history"

line="$(grep -i TotalDownLoadedBytes ~/.aMule/amule.conf)"
curr_total_in_bytes=${line#*=}

prev_total_in_bytes="$(tail -n 1 "${statsfile}" | awk '{print $2}' )"
# trim the trailing B
#prev_total_in_bytes="${prev_total_in_bytes%B}"


incremental_in_bytes=$(( curr_total_in_bytes - prev_total_in_bytes))

today=$(date "+%Y-%m-%d")
#curr_total_in_GBs=$((curr_total_in_bytes / 1024 / 1024 / 1024))
curr_total_in_GBs=$(echo "${curr_total_in_bytes} / 1024 / 1024 / 1024" | bc -l)
#incremental_in_GBs=$((incremental_in_bytes / 1024 / 1024 / 1024))
incremental_in_GBs=$(echo "${incremental_in_bytes} / 1024 / 1024 / 1024" | bc -l)

lineformat="%s   %s B   %.2f G    %.2f G\n"

printf "${lineformat}"  "${today}" "${curr_total_in_bytes}" "${curr_total_in_GBs}" "${incremental_in_GBs}" >> "${statsfile}"


