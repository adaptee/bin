#!/bin/bash

if [[ "$EUID" != "0" ]];then
    echo "Sorry, but this script require root privilege."
    echo "Please add 'sudo' as prefix."
    exit 1;
fi

this_dir=$PWD

# simple wrapper for apt-get/aptitude
function do-install ()
{
    apt-get install --yes --force-yes $@ || echo "[Error] with $@" >> /dev/stderr;
    apt-get clean
}

# simple wrapper for apt-get/aptitude
function do-purge ()
{
    apt-get purge --yes --force-yes $@ || echo "[Error] with $@" >> /dev/stderr;
    apt-get autoremove --yes --force-yes
}

#---------------------------------------------------------------------------#
#                       Remove unused packages                              #
#---------------------------------------------------------------------------#

do-purge kmousetool
do-purge akregator
do-purge dragonplayer
do-purge k3b k3b-data libk3b6
do-purge kbluetooth bluez-cups bluez-alsa bluez

do-purge printer-applet
do-purge kdepim-groupware


# I don't use this
do-purge evolution

# do not need burning CD
do-purge brasero

# I use qterm
do-purge pcmanx

# still prefer pidgin
do-purge empathy

# I use dropbox
do-purge ubuntuone-client

# I don't use scanner
do-purge xsane

# do not like this firefox addon
do-purge ubufox

# I do not use bluetooth
do-purge bluetooth gnome-bluetooth

# these old fonts are unuseful
#do-purge xfonts-75dpi xfonts-100dpi

# I don't use this bt client
do-purge transmission-common transmission-cli transmission-gtk

#---------------------------------------------------------------------------#
#                             Preparation                                   #
#---------------------------------------------------------------------------#

# first step, we should update file sources.list in current folder.
repos_list="./system/etc/apt/sources.list"

# deb URL CODENAME xxxx....
old_code_name=$( grep '^deb\>' ${repos_list} 2>/dev/null | head -1 | cut -d \  -f 3 )

# codename: xxxx ; so fetch its second field's value.
#curr_code_name=$( lsb_release -a 2>/dev/null | grep -i 'codename' | cut -f 2 )
curr_code_name=$( lsb_release -c 2>/dev/null | cut -f 2 )

# perform global substitution.
sed -i -e "s/${old_code_name}/${curr_code_name}/g" ${repos_list}

# copy system wide config back into /
cd system || { echo "subfolder system does not exist"; exit 1; }
dest_item=""
for source_item in $(find . -type f) ; do
    dest_item="/${source_item}"

    [[ -f "${dest_item}" ]] && echo cp "${dest_item}"{,.orig}
    echo cp "${source_item}" "${dest_item}"

    dest_item=""
done

# copy ssh private & public key
cd ../personal || { echo "subfolder personal does not exist"; exit 1; }
cp  ./.ssh/id_rsa     ~/.ssh/
cp  ./.ssh/id_rsa.pub ~/.ssh/
cp  ./.ssh/config     ~/.ssh/

# get the login login_username, not effective user name
login_username="$(logname)"
login_groupname="${login_username}"
chown "${login_username}":${login_groupname} ~/.ssh/*


# update and upgrade
apt-get update
apt-get upgrade --yes --force-yes

#---------------------------------------------------------------------------#
#                             Locale & Font                                 #
#---------------------------------------------------------------------------#


# install nvidia binary drivers for kernel and X11
do-install nvidia-current

# create liveusb base upon the iso of livecd
do-install usb-creator-kde

# language support for Chinese
do-install language-support-zh-hans
do-install language-pack-zh-hans
do-install language-pack-kde-zh-hans

do-install oxygen-cursor-theme oxygen-cursor-theme-extra
do-install oxygen-icon-theme oxygen-icon-theme-complete kde-icons-oxygen

do-install kdebase-workspace-wallpapers
do-install kdebase-apps
do-install kdegraphics

do-install kcharselect kgpg ktimer okteta sweeper

do-install kdewallpapers

do-install ttf-mscorefonts-installer

#do-install kde-full

# input method.
do-install ibus ibus-qt4 ibus-pinyin

# open source Chinese fonts.
do-install xfonts-wqy ttf-wqy-zenhei ttf-wqy-microhei

# fonts maker
#do-install fontforge fontforge-extras

# make Chinese fonts more beautiful.
fontconfig-voodoo -f -s zh_CN

# update font cache.
fc-cache -fv

#---------------------------------------------------------------------------#
#                                 Office                                    #
#---------------------------------------------------------------------------#

# word processor
#do-install abiword

# spreadsheet application.
#do-install gnumeric

# currently not available in repo, have to download from homepage manually.
#do-install xmind

#do-install texlive

#-----------------------------------PDF-------------------------------------#

# powerful tool for manipulating pdf documents.
#do-install pdftk

#concatenate the multiple PDF files into a single file
#do-install pdfjam

# A bunch of tools for converting pdf to other formats.
do-install poppler-data poppler-utils

# pdf password cracker
#do-install pdfcrack

#-----------------------------------Tex-------------------------------------#
# simple gui editor
#do-install winefish

#---------------------------------------------------------------------------#
#                                Programming                                #
#---------------------------------------------------------------------------#

#-----------------------------------IDE-------------------------------------#

# C/C++ IDE for GNOME.
#do-install anjuta

#do-install codelite

# cross-platform IDE
#do-install codeblocks

#do-install kdevelop

#do-install eclipse

#do-install netbeans

#do-install monodevelop

#do-install monkeystudio

# perl dev platform
#do-install padre

#-----------------------------------C/C++-----------------------------------#

# translate English phrase into valid C declaration.
do-install cdecl

# a C-code static analysis tool
do-install cflow

#generate C function prototypes based on function definitions
do-install cproto

# a static C-code analysis tool
do-install ncc

# lightweight static code checking tool for C programs.
do-install splint splint-data splint-doc-html

#Framework for source code analysis of software written in C
do-install frama-c

# utility for adjusting the indention of source code of C/C++,C#,Java,
do-install astyle

# cpp code beautifier
do-install bcpp


#-------------------------------------Python-------------------------------------#

# improved python shell
do-install ipython

do-install python-profiler

# utility to check and improve python coding style
do-install pylint
#check python scripts for common mistakes
do-install pychecker
do-install pyflakes
#do-install pythonlint

# python unittest utility
do-install python-nose
do-install python-doctest


# worksheet sytyle gui python shell
#do-install reinteract

# cross-platform python debugger.
do-install winpdb

# Yet Another python IDE.
#do-install spe

# full-featured python IDE written in PyQt4
do-install eric eric-api-files

# an Python IDE, which support embedding vim as its editor.
#do-install pida

#-------------------------------------Java---------------------------------------#

# Java platform
#do-install sun-java6-jre
#do-install sun-java6-jdk
#do-install sun-java6-plugin
#update-alternatives --config java

#All-in-One Java Troubleshooting Tool
#do-install visualvm

#-------------------------------------Qt-----------------------------------------#

# qt devel environment
do-install qt-creator
do-install qt4-qtconfig
#do-install qt4-dev-tools qt4-designer python-qt4

#---------------------------------Text editor----------------------------------#

# VIM, the best text editor  human being has ever created.
do-install vim-gnome
do-install exuberant-ctags

# Gedit
#do-install gedit gedit-plugins

# graphical css editor
#do-install cssed csstidy

# lightweight cross-platform text/hex editor.
#do-install madedit

# lightweight and cross-platform text editor.
#do-install scite

# not available in repo
#do-install xmlcopyeditor

# a versatile XML editor, non-available
#do-install serna

# PO-file(i18n) editor for gettext
#do-install gtranslator

#---------------------------------Hex editor----------------------------------#

# vi-style hex-editor
do-install bvi

# console based hex-editor with vim-style key-bindings.
do-install hexer

# hex editor, which provide special support for ELF format files.
do-install ht

# hexadecimal differ
do-install hexdiff

#---------------------------------diff & merge---------------------------------#

# A wrapper for diff, which add colored highlighting to improve readability.
do-install colordiff

# still not clear its utilily.
do-install diffstat

# yet another graphical diff and merge tool
do-install diffuse

# graphical tools for differing and merging files.
do-install meld

# differ&mrege tool
do-install kdiff3

#do-install kompare

# compare in the level of word
do-install wdiff

# beyond compare for linux, have to download from homepage manually.
#do-install bcompare

# utility suite for working with patches
do-install patchutils

#---------------------------------building tools--------------------------------#

# basic programming environment, such as gcc, g++, make, etc.
do-install build-essential


# gold linker , a replacement for standard ld
#do-install binutils-gold

# auto-tools suite
do-install autoconf automake libtool

#  another make
do-install cmake

# building system written in python
do-install scons

#-----------------------------------Debugger------------------------------------#

do-install gdb gdb-doc

# console ui for gdb
do-install cgdb


#do-install ddd

# gui front-end of GDB for GNOME.
#do-install nemiver

# gui front-end of GDB for KDE
#do-install kdbg

#improved support for assertions and logging in C/C++
do-install nana

#Analyze Linux crash data or a live system
do-install crash

#a memory-usage debugger for C++ programs
do-install leaktracer

# An bash script debugger.
do-install bashdb

# print a stack trace of running processes
do-install pstack

# dbus debugger
#do-install d-feet

#-----------------------------------Profiler------------------------------------#

# system level profiler
do-install sysprof

# gui frontend for gcov from GCC
do-install ggcov lcov

# full feature dynamic profiler
do-install valgrind
# frontend for gnome and kde
do-install alleyoop kcachegrind

#-----------------------------------Git tools-----------------------------------#

do-install git-core git-doc git-gui git-svn

# git gui.
do-install gitg qgit gitk # giggle git-cola

# console-based git ui.
do-install tig

# generate stat report for git repo
do-install gitstats

# git repository hosting application
#do-install gitosis python-setuptools

#-------------------------------------Document----------------------------------#

# manpages for linux system call and library calls.
do-install manpages-dev

# document for Gnome developer
do-install devhelp devhelp-common

# manpages for GNU C library.
do-install glibc-doc

do-install debian-policy developers-reference debian-goodies

# gui tools for manipulating manpages
#do-install gmanedit

do-install graphviz graphviz-doc graphviz-cairo

#------------------------------------- Formatter--------------------------------#

# utility for adjusting the indention of C source code.
do-install indent

# adjust the formatting of xml/html files
do-install tidy

# adjust the indentation of xml file.
do-install xmlindent

# perl script indenter and reformatter
do-install perltidy

#------------------------------------ Toy language------------------------------#

# erlang development platform
do-install erlang erlang-manpages

# development suite for haskell programmers
do-install ghc6 ghc6-doc haskell-doc

# a stand-alone JavaScript interpreter
do-install spidermonkey-bin

# lexer and parser
do-install flex bison

# dev platform for Ocaml
#do-install cameleon

#------------------------------------ SQL---------------------------------------#

# gui editor for SQLite databases
#do-install sqlitebrowser

# gui managing tool for mysql
#do-install gmysqlcc emma

#do-install mysql-admin mysql-query-browser

#------------------------------------Regex--------------------------------------#

# console-based interactive guidance for writing regex.
do-install txt2regex

# gui tools for testing regex in python.
#do-install kiki

#UML Modeling tool
#do-install gaphor

# GTK+2 UI builder.
#do-install glade

# converting source code to HTML/Pdf/RTF/Tex with syntax highlighting.
do-install highlight

# markup conversion tools
do-install txt2man txt2html txt2tags
do-install python-docutils rest2web

# necessary devil
do-install svn

do-install mercurial

# kde front-end for svn
#do-install kdesvn

# fix-me
#do-install autogen


#---------------------------------------------------------------------------#
#                                 Desktop
#---------------------------------------------------------------------------#

#-----------------------------File Manager----------------------------------#

# add the 'open in terminal' menu entry
do-install nautilus-open-terminal

# allow  you to share file through samba without root privilege
do-install nautilus-share

# a great extension for nautilus, which allow you to preview
# almost everything with <Space>
do-install gloobus-preview

# allow user to custom what to do when removable media is inserted
# correspond to menu entry "System->Preference->Removable media"
do-install gnome-volume-manager

# gui tools based upon hal
do-install gnome-device-manager

do-install pmount

# two-pane file manager.
do-install emelFM2

# lightweight file manager
do-install pcmanfm

# powerful two-pane file manager for KDE
#do-install krusader

#---------------------------Terminal Emulator------------------------------#

# window manager for terminal .
do-install terminator

# sexy terminal on your call.
do-install tilda

# similar to tilda
#do-install yakuake

#---------------------------------applet------------------------------------#

# show interface speed
do-install gnome-netstatus-applet

# show netspeed
do-install netspeed

# simple time tracking utility
do-install hamster-applet

#-------------------------------screen-shot----------------------------------#
# full-featured screen-shot application.
do-install shutter

# screen-shot tools
do-install  scrot

# screen-cast capture, generator flash file.
#do-install wink

#-------------------------------Archives----------------------------------#

# support for common archive format
do-install rar unrar p7zip

# unpack (almost) everything with one command
do-install unp dtrx atool

# full-featured cross-platform archive manager.
# not available in the repo
#do-install peazip


# text expansion and hotkey for X Window.
do-install autokey-gtk

# let any program support the sys-tray
#do-install alltray

# nofifier
do-install libnotify-bin

# compiz manager
do-install compizconfig-settings-manager

# Graphical editor for gconf configuration database.
do-install gconf-editor

# Excellent app launcher for GNOME.
do-install gnome-do gnome-do-plugins

# chm viewer.
do-install chmsee

# lightweight clipboard manager for GNOME.
#do-install parcellite

# desktop widget for GNOME.
#do-install screenlets

# powerful dictionary app.
#do-install stardict

# educational app
do-install anki

# virtual machine.
do-install virtualbox-3.2

# create live-usb based on distribution ISO.
#do-install unetbootin

# various useful non-open-sourced package
do-install ubuntu-restricted-extras

#---------------------------------------------------------------------------#
#                                Internet                                   #
#---------------------------------------------------------------------------#

#---------------------------------Download----------------------------------#

# powerful ed2k client for GNOME.
do-install amule  amule-daemon amule-utils
#do-install amule-gnome-support

# full-featured BT client.
do-install deluge-torrent deluge-console deluge-webui

# console-based multi-thread downloading utility.
do-install axel

# general file transferring tools.
do-install curl

# multi-thread download tool
do-install aria2

# console-based powerful ftp client.
do-install lftp

# simple script for downloading youtube video.
#do-install youtube-dl

# user-space speed limiter
do-install trickle

#-----------------------------------Browser--------------------------------#
# web browser by Google.
do-install google-chrome-unstable

# My favourite BBS Client
do-install qterm

# flash plugin by adobe.
do-install flashplugin-nonfree

#-----------------------------------IM--------------------------------------#

# IRC client.
do-install xchat

# VOIP.
do-install skype

# console based jabber client
#do-install freetalk

# IM client supporting multiple protocal.
do-install pidgin msn-pecan pidgin-plugin-pack

#-----------------------------------Email------------------------------------#

# console based mail client
#do-install alpine

# mail client, which sucks less
#do-install mutt

#--------------------------------Share & Sync---------------------------------#

# share files with windows.
do-install  samba smbfs smbclient winbind

# sophisticated gui tool for configuration samba
#do-install gadmin-samba
# simple gui tool for configuring samba
#do-install system-config-samba

# dropbox integration with nautilus.
do-install nautilus-dropbox

# file sharing for LAN
do-install g2ipmsg

# great file-sharing utility for LAN environment.
#do-install iptux


#-----------------------------------SSH---------------------------------------#

# client side
do-install openssh-client

#scans the network for open SSH servers
do-install scanssh

#monitor and restart ssh sessions
do-install autossh

#SSH tunnel manager for GNOME
do-install gstm

#re-use ssh-agent and/or gpg-agent between logins
do-install keychain

# server side
#do-install openssh-server

#Protects from brute force attacks against ssh
#do-install sshguard


#--------------------------------Utility------------------------------------#

# swiss army for networking
#do-install netcat

# a better netcat
do-install socat

# a cli client for various pastebin services.
do-install pastebinit

# multi-ping utility for specified hosts.
do-install pinger

# send (almost) arbitrary TCP/IP packets to network hosts
do-install hping3

# packet grabbing
#do-install wireshark

#--------------------------------Security------------------------------------#

# crack wep/wpa key
do-install aircrack-ng

# powerful utility for network exploration or security auditing
#do-install nmap

# An network intrusion prevention and detection system
# interactive installation, trouble-some
#do-install snort

#network packet stream editor
do-install netsed


#---------------------------------------------------------------------------#
#                                Desktop                                    #
#---------------------------------------------------------------------------#

# super-cool wm!
#do-install compiz compiz-core compiz-gnome compiz-plugins
#do-install compizconfig-settings-manager

# comic viewer for GNOME.
do-install comix

# lightweight color picker for GNOME.
#do-install gcolor2

# simple image viewer.
#do-install geeqie

# image viewer and browser.
do-install gthumb

# vector-based drawing app.
#do-install inkscape



#---------------------------------------------------------------------------#
#                                    Media                                  #
#---------------------------------------------------------------------------#

#--------------------------------Player------------------------------------#


# An winamp style mp3 player.
do-install audacious audacious-plugins audacious-plugins-extra  pidgin-audacious

# the gnome version of amarok
do-install exaile

# Most powerful video player.
do-install  mplayer mencoder mozilla-mplayer

# convenient front-end for mplayer.
do-install smplayer

do-install ffmpeg

do-install gstreamer0.10-ffmpeg

do-install libvdpau1

do-install xbmc xbmc-standalone

# decoders for various video format.
do-install  libdvdcss2 libdvdnav4 libdvd0 libdvdread4 w32codecs

# full-featured media player
#do-install vlc

# live video for linux, depending upon mplayer and sopcast.
do-install gmlive sopcast

# install useful plugin for totem
do-install totem-pps totem-mozilla

# lightweight console-based audio player.
do-install cmus

# lightweight console-based audio player.
#do-install moc

# lightweight console-based audio player.
#do-install mp3blaster




#--------------------------------Converter---------------------------------#

# three friendly wrapper for mencoder
do-install divxenc xvidenc h264enc

# for transforming the encoder of mp3 tag info.
# run “find . -iname "*.mp3" -execdir mid3iconv -e GBK {} \;”
do-install python-mutagen

# mp3 tagger
do-install picard

# video editor.
#do-install avidemux

# Graphical editor for subtitle of movies.
#do-install subtitleeditor


#---------------------------------------------------------------------------#
#                                System                                     #
#---------------------------------------------------------------------------#

# FUSE module to mount ISO filesystem images
do-install fuseiso

#  contains socklist, which can list open sockets
do-install procinfo

# contains pmap, which show process's memory map
do-install procps

#------------------------------Backup & Sync-------------------------------#
# fast remote file copy program.
do-install rsync

# an incremental backup utility written in python
do-install rdiff-backup

# simple backup system.
#do-install backintime-gnome

# file synchronization tools for windows and linux.
#do-install unison unison-gtk

#do-install backup-manager

#Backup directory tree and files
do-install dar

#------------------------------FS utility---------------------------------#

# graphical partition management tool
do-install gparted

# tools for creating and maintaining reiserfs
do-install reiserfsprogs

# tools for checking filesystems, especially those broken symbol links.
#do-install fslint

# unavailable in repo
#do-install easycrypt
#do-install truecrypt

#--------------------------------Hardware----------------------------------#

# display info for various hardwire in the system.
do-install hardinfo
do-install lshw
do-install hwinfo

# graphical configuration tool for touchpad
#do-install gsynaptics

#--------------------------------X Window----------------------------------#
# x event simulator
do-install xdotool

# X server monitor
do-install xrestop

#a window information utility for X
do-install wininfo

# 'luit', an filter running between an arbitrary application and
# a UTF-8 terminal emulator
do-install x11-utils

# perform specified actions on windows as they are created
do-install devilspie



#---------------------------------------------------------------------------#
#                                Monitoring                                 #
#---------------------------------------------------------------------------#

#--------------------------------Network------------------------------------#

# bandwidth monitor for the whole system.
do-install bmon

# show bandwidth stats for specified network interface.
do-install iftop

# interactive colorful LAN monitor
do-install iptraf

# another network load monitor
do-install slurm

#----------------------------------Top--------------------------------------#

#  top improved
do-install htop

# simple top-style I/O monitor
do-install iotop

# find which software is consuming most power.
do-install powertop

#a tool for developers to visualize system latencies
do-install latencytop

# simple top-style monitor for MySql
do-install mytop


#----------------------------------Stats-------------------------------------#

# versatile resource stat tool, a replacement for vmstat,iostat, ifstat.
do-install dstat

# Identify what’s using up virtual memory, especially useful for shared lib.
do-install memstat

# provide several tools: vmstat, iostat, mpstat, pidstat,etc.
do-install sysstat

#----------------------------------General------------------------------------#

# powerful and highly-configurable system monitor for X environment.
do-install conky

# A group of programs to gather data from multiple hosts
#do-install munin

# utility for monitoring daemon services on a Unix system
#do-install monit


#---------------------------------------------------------------------------#
#                            Console Tools                                  #
#---------------------------------------------------------------------------#

#----------------------------------Shell------------------------------------#
# the ultimate shell
do-install zsh

# distributed shell
#do-install dish
#do-install dsh

# clutterssh- administer multiple ssh or rsh shells simultaneously
#do-install clusterssh

#Parallel versions of SSH tools
#do-install pssh


#--------------------------------Console WM---------------------------------#

# you can't miss this!
do-install screen

#  screen improved
do-install byobu byobu-extras

# window manager for console, similar to screen.
do-install tmux

# Tiling window management for the console, similar to terminator under X.
do-install dvtm

#--------------------------------Console FM---------------------------------#

# console-based two pane file manager.
do-install mc

# console-based two pane file manager, which provide vim-style key binding.
do-install vifm

#bookmarks and browsing for the cd command
do-install cdargs

#-------------------------------- Encoding---------------------------------#


# utility for transferring the encoding of filenames.
do-install convmv

# simple tools for detecting charset and encoding of text files.
do-install enca


#-------------------------------- FS utility-------------------------------#

# du improved , add percentage and auto sorting.
do-install ncdu

# colorized df written in python.
do-install pydf

# show directory tree in color.
do-install tree

# command-line tools for the inotify feature provided by kernel
do-install dnotify inotify-tools

#----------------------------------Others----------------------------------#

# grep-like text finder written in perl better than grep
do-install ack-grep

#a grep with Perl-compatible regular expressions
do-install pcregrep

# another grep which support approximate matching
do-install agrep

# grep for network packets
do-install ngrep

# ext3 file recovery tool
do-install ext3grep

#Filter IP addresses based on IPv4 CIDR/network specification
do-install grepcidr

# programs for dealing with numbers from the command line
do-install num-utils


# command line interface for trashcan
do-install  trash-cli

# console version of stardict
do-install sdcv

# framebuffer based terminal emulator
#do-install fbterm

# setting, snapshot, imagevier for framebuffer
do-install fbset fbgrab fbv

# A cool app which simulate the matrix.
do-install cmatrix cmatrix-xfont

# tools for automating interactive applications.
do-install expect expect-dev

# tail multi files at the same tile.
do-install multitail

# monitor the progress of data through a pipe
do-install pv

# similar to pv
do-install cpipe

# lock your console for safety.
do-install vlock

# lock your x-session
do-install xlockmore


#---------------------------------------------------------------------------#
#                                Clean-Up                                   #
#---------------------------------------------------------------------------#

do-install apt-file
apt-file update

apt-get clean
apt-get autoclean


#---------------------------------------------------------------------------#
#                                Post configuration                        #
#---------------------------------------------------------------------------#

# fetch various dotfiles
/bin/su ${login_username} -c "\
cd ~ ; \
git clone git@github.com:adaptee/dotfiles ;\
cd dotfiles
git checkout -b gnome origin/gnome"


# remove unneeded locale data when installing each debian package.
# interactive installation, trouble-some
do-install localepurge

#---------------------------------------------------------------------------#
#                      problematic interactive installation                 #
#---------------------------------------------------------------------------#

# applet for cpu temperature
do-install sensors-applet


do-install acire python-snippets python-vte

do-install flac monkeys-audio wavpack
do-install shntool cuetools lltag

# crack the password of windows,zip,pdf
do-install ophcrack fcrackzip pdfcrack
