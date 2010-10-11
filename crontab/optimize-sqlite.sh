#!/bin/bash
#===============================================================================
#
#          FILE:  optimize-sqlite.sh
#
#         USAGE:  ./optimize-sqlite.sh
#
#   DESCRIPTION:  optimized all sqlite database file's size
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  adaptee (), adaptee@gmail.com
#       COMPANY:  Open Source Corporation
#       VERSION:  1.0
#       CREATED:  2009年09月09日 05时41分07秒 CST
#      REVISION:  ---
#===============================================================================

cd ~/.mozilla/firefox/  || exit  2

find .  -name '*.sqlite'  -exec sqlite3 '{}' 'VACUUM;'  \;
find .  -name '*.sqlite'  -exec sqlite3 '{}' 'REINDEX;' \;

