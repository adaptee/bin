#!/bin/bash
#===============================================================================
#
#          FILE:  update-vim-help-tags.sh
#
#         USAGE:  ./update-vim-help-tags.sh
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
#       CREATED:  04/11/10 17:14:04 CST
#      REVISION:  ---
#===============================================================================


cd $HOME/.vim/rc
ctags -R .

