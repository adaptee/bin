#!/bin/bash
#===============================================================================
#
#          FILE:  build-vim7.sh
#
#         USAGE:  ./build-vim7.sh
#
#   DESCRIPTION:  build lateset version vim automatically
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  adaptee (), adaptee@gmail.com
#       COMPANY:  Open Source Corporation
#       VERSION:  1.0
#       CREATED:  2010年03月10日 23时49分06秒 CST
#      REVISION:  ---
#===============================================================================


#cd ~/code/vim7 || exit 2
cd ~/code/vim || exit 2

# clear pervious built
make distclean

# chekcout the latest version
#svn update
hg pull
hg update

./configure --prefix=/usr --with-x=yes
            --enable-gui=gtk2     \
            --enable-cursorshape  \
            #--enable-debug        \
            --enable-profile      \
            --enable-startuptime  \
            --enable-sign         \
            --disable-arabic      \
            --disable-ballooneval \
            --disable-cryptv      \
            --disable-dnd         \
            --disable-emacstags   \
            --disable-hangulinput \
            --disable-perl        \
            --disable-ruby        \
            --disable-clientserver

make


