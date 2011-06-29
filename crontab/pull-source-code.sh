#!/bin/bash
#===============================================================================
#
#          FILE:  update-source-code.sh
#
#         USAGE:  ./update-source-code.sh
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
#       CREATED:  09/13/10 07:00:43 CST
#      REVISION:  ---
#===============================================================================

BRIGHTGREEN=$(tput bold;tput setaf 2)
NOCOLOR=$(tput sgr0)

BASES=("$HOME/code" "$HOME/code/archlinux" "$HOME/code/gentoo" "$HOME/code/kde" "$HOME/code/ibus" "$HOME/code/@adaptee")

function Is-Git-Svn-Repo ()
{
    if  git branch -a  2>/dev/null | grep 'git-svn$'  >& 2>/dev/null ; then
        return 0
    else
        return 1
    fi
}

# echo text in green color
function green-echo ()
{
    echo -e "${BRIGHTGREEN}$@${NOCOLOR}"
}

cd ~/code/amule-svn && git push origin master

for BASE in ${BASES[@]} ; do

    echo "[BASE]: ${BASE}"

    cd "${BASE}" ||  exit 1

    for item in ./*/ ; do

        cd "${item}" || continue

        #echo -e "${BRIGHTGREEN}${item}${NOCOLOR}"
        green-echo "[debug]:${item}"

        if  Is-Git-Svn-Repo ; then
            #git svn fetch
            git svn rebase

        elif [ -d ".git/" ] ; then
            git pull --prune

        elif [ -d ".svn/" ] ; then
            svn update
            svn log > svn.log

        elif [ -d ".hg/"  ] ; then
            hg pull
            hg update

        elif [ -d ".bzr/" ] ; then
            bzr merge

        else
            true
        fi

        echo ""

        # output one additonal blank line, makeing it visiaully more clear
        cd ../

    done

done



