#!/bin/bash
#===============================================================================
#
#          FILE:  bash-history-archiver.sh
#
#         USAGE:  ./bash-history-archiver.sh
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
#       CREATED:  09/23/10 14:12:02 CST
#      REVISION:  ---
#===============================================================================


# stolen from http://mywiki.wooledge.org/BashFAQ/088

# This script removes enough lines from the top of the history file,
# to truncate its size to X lines, appending the truncated conetents
# to ~/.bash_history.archive.

umask 077
max_lines=10000

linecount=$(wc -l < ~/.bash_history)

if (($linecount > $max_lines)); then
        prune_lines=$(($linecount - $max_lines))
        head -$prune_lines ~/.bash_history >> ~/.bash_history.archive \
            && sed -e "1,${prune_lines}d"  ~/.bash_history > ~/.bash_history.tmp$$ \
            && mv ~/.bash_history.tmp$$ ~/.bash_history
fi
