#!/bin/bash


#---------------------------------------------------------------------------#
#                              convenient functions                         #
#---------------------------------------------------------------------------#


# simple wrapper for yaourt/pacman
function install-do ()
{
    yaourt -S --noconfirm $@
    #rm /var/cache/pacman/pkg/*
}

# simple wrapper for yaourt/pacman
function purge-do ()
{
    pacman -Rs $@
}

#---------------------------------------------------------------------------#
#                            0  Prepare user & gruop                        #
#---------------------------------------------------------------------------#

useradd -m -s /bin/bash whodare

#https://wiki.archlinux.org/index.php/Group
gpasswd -a whodare audio
gpasswd -a whodare video
gpasswd -a whodare power
gpasswd -a whodare storage
gpasswd -a whodare network
gpasswd -a whodare vboxusers
gpasswd -a whodare wheel
gpasswd -a whodare log
# [dangerous]
# gpasswd -a whodare disk

#---------------------------------------------------------------------------#
#                            1  Package management                          #
#---------------------------------------------------------------------------#

#first step after installaion
pacman -Syy
pacman -Syu

# upgrade pacman itself
install-do pacman

# AUR is easy with  yaourt
install-do yaourt

# upload tarball to AUR
install-do burp

# make pacman colorful
install-do pacman-color

# bacman is its most valuable component
install-do pacman-contrib

# various shell tools for working with PKGBUILD
install-do pkgtools

install-do pactools


install-do pacgraph

# wrapper for pacman, accelerating downloading speed with the help of aria2
install-do bauerbill

#  A cached pacman implementation that boosts some pacman operations
#  written in php. WOW@
#install-do tupac

# a drop-in replacement for yaourt
#install-do paktahn

# editing PKGBUILD is easy with vim now
install-do vim-pkgbuild

# analyze PKGBUILD or archive file for known problem
install-do namcap

# binary differ tool, useful for the delta update of pacman
install-do xdelta3

# install devel tools for building package from source
install-do base-devel


#---------------------------------------------------------------------------#
#                            2  X Window System                             #
#---------------------------------------------------------------------------#

install-do xorg


# evdev take cares of both keyboard and mouse
install-do xf86-input-evdev
#install-do xf86-input-mouse
#install-do xf86-input-keyboard

# touchpad
install-do xf86-input-synaptics

# nvidia driver
install-do nvidia nvidia-utils

# overclocking your nvidia card
install-do nvclock

# necessity
install-do dbus

# x event simulator
install-do xdotool

# X server monitor
install-do xrestop

#a window information utility for X
install-do wininfo

# 'luit', an filter running between an arbitrary application and
# a UTF-8 terminal emulator
install-do x11-utils

# perform specified actions on windows as they are created
#install-do devilspie

# FAM is reprecated
install-do gamin


#---------------------------------------------------------------------------#
#                            3  KDE                                         #
#---------------------------------------------------------------------------#

# the simlpe but dirty way
#install-do kde

# the verbose but elegent way
install-do kde-mata-kdeaccessibility
install-do kde-mata-kdeadmin
install-do kde-mata-kdeartwork
install-do kde-mata-kdebase
install-do kde-mata-kdeedu
install-do kde-mata-kdegraphics
install-do kde-mata-kdemultimedia
install-do kde-mata-kdenetwork
install-do kde-mata-kdepim
install-do kde-mata-kdeplasma-addons
install-do kde-mata-kdesdk
install-do kde-mata-kdeutils
install-do koffice-meta-koffice

install-do oxygen-icons-svg

# make gtk apps look better under kde
install-do oxygen-gtk-git

# oxygen icons ported for gtk
install-do oxygenrefit2-icon-theme
install-do hydroxygen-iconset

# native svn client for KDE
install-do kdesvn

# not of much use
purge-do kdeutils-kdf

# do not use remote control
purge-do kdeutils-kremotecontrol

# do not need eye-candy stuffs
purge-do kdeutils-superkaramba

# nobody use floppy nowadays, really
purge-do kdeutils-kfloppy

# do not use printer
purge-do kdeutils-printer-applet

# translations
install-do kde-l10n-zh_cn

# allow gtk apps to comply to kde style and theme
#install-do gtk-kde4

# touchpad module for kde system setting
install-do kcm_touchpad

# A touchpad tool for KDE.
install-do synaptiks-git

# mplayer rules all!
purge-do kdemultimedia-dragonplayer

# music player without cool feature
purge-do kdemultimedia-juk

# wget is better
purge-do kdenetwork-kget

# rarely dial-up now
purge-do kdenetwork-kppp

# I use google-reader for RSS
purge-do kdepim-akregator

# not interested with most kdeedu apps
# however, these apps seems quite useful
install-do kdeedu-kiten
install-do kdeedu-kwordquiz
install-do kdeedu-parley
install-do kdeedu-ktouch

# language learning cards
#install-do anki

# two kde photo management apps
install-do digikam
#install-do kphotoalbum

# a plugin for Kate that allows you to create new plugins in Python
install-do pate-git

# A Splash Screen Editor and Creator for KDE4
install-do ksplasherx

# A service menu to put the path of a file or directory into the Klipper
#install-do copypath-servicemenu-kde4


#---------------------------------------------------------------------------#
#                            4  audio & video                               #
#---------------------------------------------------------------------------#

# ALSA is the base of everying
install-do alsa-utils

# pulseaudio is the right choice
install-do pulseaudio

# these 2 package can ask ALSA to use pulseaudio as default
install-do alsa-plugins pulseaudio-alsa

# gstreamer is uesful, sometimes
# also make gstreamer support pulseaudio
install-do gstreamer0.10-{{bad,good,ugly,base}{,-plugins},ffmpeg,pulse}

# winamp-like mp3 player.
install-do audacious

# foobar-like music player
install-do deadbeef

# lightweight console-based audio player. Vim-sytle keybindings
install-do cmus

# amarok rules all!
install-do amarok

# Most powerful video player.
install-do  mplayer codecs

# convenient front-end for mplayer.
#install-do smplayer

# full-featured media player
# also make it support pulseaudio
install-do vlc vlc-plugin

# tools for mkv container format
install-do mkvtoolnix

# decoders for various video format.
install-do libdvdcss libdvdnav libdvdread

# video editor of KDE
install-do kdenlive

# friendly video editor
#install-do openshot

# live video for linux, depending upon mplayer and sopcast.
#install-do gmlive sopcast

# it provides linux client, again !
install-do ppstrem

# three friendly wrapper for mencoder
install-do h264enc

# for transforming the encoder of mp3 tag info.
# find . -iname '*.mp3' -execdir mid3iconv -e GBK '{}' \;
install-do mutagen

# python binding to taglib
install-do tagpy

# tag editors
install-do kid3 easytag puddletag

# mutagen-based tag encoding converter
# optimized for Chinese
install-do mp3tagiconv

# audio converter
install-do soundkonverter

# dvd ripper
install-do handbrake
install-do hypervideoconverter

# Graphical editor for subtitle of movies.
install-do subtitlecomposer
#install-do subtitleeditor

# encoder/decoder for popular lossless audio format
install-do  flac wavpack mac-port ttaenc vorbis-tools

# necessary tools for spliting big ape/flac into mutilple files
install-do  shntool cuetools lltag

# gui tool for split ape/flac
install-do flacon

# convert other lossless audio format to flac, preseving tag info
#install-do split2flac-hg

# convert flac to mp3
install-do flac2mp3-bash

# script for transforming alac format to flac
install-do alac2flac

#---------------------------------------------------------------------------#
#                            5  Networking                                  #
#---------------------------------------------------------------------------#

# local DNS proxy cache
install-do dnsmasq

# similar to dnsmsq, but the cache is more persistent
install-do pdnsd

# much much bettter than networkmanager
install-do wicd-nogtk wicd-client-kde

install-do iproute2

install-do iptables

# grep network packets
install-do ngrep

# best ed2k client under linux
install-do amule

# best bittorrent client under linux
install-do ktorrent

# rtorrent patched for vi keybindings and color
install-do rtorrent-vi-color

# multi-thread download tool(support metalink)
install-do aria2

# powerful console-based ftp client.
install-do lftp

# firefox is still my favour
install-do firefox firefox-i18n

# we all hate it, but still need it
install-do flashplugin

# optimized version of firefox
#install-do swiftfox-prescott

# web browser by Google.
install-do google-chrome

# pure text browser
install-do w3m elinks

# access various google service from commandline
install-do googlecl

# IM client supporting multiple protocal.
install-do pidgin msn-pecan

# IRC client.
install-do xchat

# another msn client
install-do emesene

# another msn client
#install-do kmess

# VOIP.
install-do skype

# console based jabber client
#install-do freetalk


# mail client, which sucks less
install-do mutt

# console based mail client
#install-do alpine

# share files with windows.
install-do  samba smbclient

# mount the whole neighbourhoods
install-do fusesmb
install-do smbnetfs

# file sharing for LAN(gtk2 and qt frontend)
install-do g2ipmsg
install-do qipmsg

# great file-sharing utility for LAN environment.
install-do iptux

# monitor and restart ssh sessions
#install-do autossh

# re-use ssh-agent and/or gpg-agent between logins
install-do keychain

# multi-ping utility for specified hosts.
install-do pinger

# ping multiple hosts at one time
install-do fping

# like ping, but for http-requests.
install-do httping

# mtr = ping + trace
install-do mtr

# send (almost) arbitrary TCP/IP packets to network hosts
install-do hping3

# query whois info about domain name
install-do whois

# packet grabbing
#install-do wireshark

# a better netcat
install-do socat

# netcat rewritten by GNU
install-do gnu-netcat

# user-space speed limiter
#install-do trickle wondershaper

# crack wep/wpa key
#install-do aircrack-ng

# a cli client for various pastebin services.
#install-do wgetpaste

# powerful utility for network exploration or security auditing
install-do nmap

# two gui frontend for nmap
#install-do umit

# An network intrusion prevention and detection system
# interactive installation, trouble-some
#install-do snort

# an powerfull network packet sniffer and injecter
install-do hexinject

# provide command nslookup, dig and host
install-do dnsutils

# auto-downloader for file hoster like rapidshare
install-do slimrat

# similar to slimrat
install-do tucan pyload plowshare

# light-weight personal wiki
install-do dokuwiki

#---------------------------------------------------------------------------#
#                             6  Office                                     #
#---------------------------------------------------------------------------#

# after all, this is still the best you can expect
install-do  acroread

# lightweight pdf viewer
install-do zathura

# best mindmap app
install-do xmind

# for okular to display Chinese font correctly
install-do poppler-data

# A bunch of tools for converting pdf to other formats.
#install-do poppler-utils

# powerful tool for manipulating pdf documents.
#install-do pdftk

# concatenate multiple PDF files into a single file
#install-do pdfjam

# currently the best you can expect
install-do libreoffice

# presentation slide is really easy to make
instal-do smile

# word processor
#install-do abiword

# spreadsheet application.
#install-do gnumeric

# a complete tex development environment
#install-do texlive-most
install-do texlive-core texlive-bin texlive-langcjk latex-beamer

# tex editor for KDE
install-do kile
#install-do texmaker
#install-do lyx

# chm viewer for kde/qt
install-do kchmviewer

# similar to kchmviewer, but has better support for Chinese
install-do pychmviewer

# .djvu view written in qt
install-do djview4

# convert djvu to pdf
install-do djvu2pdf

#---------------------------------------------------------------------------#
#                             7  Locale & Font                              #
#---------------------------------------------------------------------------#

# input method.
install-do ibus ibus-qt ibus-pinyin ibus-sunpinyin

# patches provided by ubuntu
purge-do   cairo fontconfig libxft freetype2
install-do cairo-ubuntu fontconfig-ubuntu libxft-ubuntu freetype2-ubuntu
#install-do freetype2-infinality

# open source Chinese fonts.
install-do wqy-microhei

# without this package, the delicious plugin of firefox will sholw english
# text in very ugly style
install-do ttf-ms-fonts

# fonts from mac OS
install-do ttf-mac-fonts

# fonts for programmer
install-do ttf-dejavu ttf-bitstream-vera ttf-inconsolata

# font manager written in python for Gnome
#install-do font-manager

# obsolete old fonts
purge-do xorg-fonts-75dpi xorg-fonts-100dpi


# delete un-needed locale stuff
install-do localepurge

#---------------------------------------------------------------------------#
#                              8  Programming                               #
#---------------------------------------------------------------------------#


#-----------------------------------IDE-------------------------------------#

# qt-oriented ide
install-do qt-creator

# development platform from kde
install-do kdevelop


# big names
install-do eclipse
#install-do netbeans

# perl-oriented IDE
#install-do padre

#-----------------------------------C/C++-----------------------------------#

# translate English phrase into valid C declaration.
install-do cdecl

# a C-code static analysis tool
install-do cflow cppchecker

# a static C-code analysis tool
install-do ncc

# lightweight static code checking tool for C programs.
install-do splint

#Framework for source code analysis of software written in C
#install-do frama-c

# utility for adjusting the indention of source code of C/C++,C#,Java,
install-do astyle


#-------------------------------------Python-------------------------------------#


# improved python shell
install-do ipython



# utility to check and improve python coding style
install-do pylint

# co-operate very well with vim
install-do pyflakes

#check python scripts for common mistakes
install-do pychecker


install-do eclipse-pydev eclipse-vrapper
# commerical python IDE
install-do wingide

#python implementation of lex and yacc
install-do python-ply

# makes writing C extensions for Python as easy as Python itself.
install-do cython

install-do python-profiler

# python unittest utility
install-do python-nose
install-do python-doctest

# python documentation generator
install-do python-sphinx

# worksheet sytyle gui python shell
#install-do reinteract

# interactive python debugger
install-do pydb

install-do python-ptrace

# full-featured python IDE written in PyQt4
install-do eric eric-api-files

# wrap c/c++ code into script language, such as python
install-do swig

# Python style guide checker
install-do pep8

# a drop-in replacement for easy_install
install-do python-pip

#-------------------------------------Java---------------------------------------#

# Java platform
#install-do sun-java6-jre
#install-do sun-java6-jdk
#install-do sun-java6-plugin
#update-alternatives --config java

#All-in-One Java Troubleshooting Tool
#install-do visualvm


#---------------------------------Text editor----------------------------------#

# VIM, the best text editor human being has ever created.
# first, we need to remove the old vi
purge-do vi
install-do gvim
install-do ctags

# a good os, but a bad editor
install-do emacs

# great spell checker, better than ispell?
install-do aspell aspell-en

# install the GNU diction and style, nice tools for chekcing English writing
install-do diction

# lightweight cross-platform text/hex editor.
install-do madedit

# not available in repo
#install-do xmlcopyeditor

# a versatile XML editor, non-available
#install-do serna

#---------------------------------Hex editor----------------------------------#

# vi-style hex-editor
install-do bvi

# another vi-style hex-editor
install-do hexer

# hex editor, which provide special support for ELF format files.
install-do ht


#---------------------------------diff & merge---------------------------------#

# compare in the level of word
install-do wdiff

# A wrapper for diff, which add colored highlighting to improve readability.
install-do colordiff

# still not clear its utilily.
install-do diffstat

# support 3-way merging. That'w why it's call kdiff3
install-do kdiff3

# diff for binary files
install-do bsdiff

# colletion of tools for patching
install-do patchutils


#---------------------------------building tools--------------------------------#

# gold linker , a replacement for standard ld
#install-do binutils-gold

#  another make
install-do cmake


#-----------------------------------Debugger------------------------------------#

# needless to say
install-do gdb

# gui front-end of GDB for KDE
#install-do kdbg-git

#The GNU Debugger with C++ debugging improvements (Archer Fedora branch)
#install-do gdb-archer-fb-git

# An bash script debugger.
install-do bashdb

# print a stack trace of running processes
install-do pstack

install-do strace lstrace

# C library replicating the 'bt' functionality of gdb
install-do libbacktrace

# dbus debugger
#install-do d-feet
#install-do dbug-inspector
#install-do lsdbus


#-----------------------------------Profiler------------------------------------#

# system level profiler
install-do sysprof

# gui frontend for gcov from GCC
install-do ggcov lcov

# full feature dynamic profiler
install-do valgrind

# frontend of valigrind for kde
install-do kcachegrind

#-----------------------------------Git tools-----------------------------------#

install-do git

# Qt-based frontend of git .
install-do gitg qgit

# console-based frontend of git .
install-do tig

# provide command `gitserve`, an simulation of `hg serve`
gitserver-python

# git history visualization tool
#install-do gource


# necessary devil
install-do svn

#------------------------------Mercurial tools---------------------------------#

install-do mercurial

# history viewer, similar to qgit of git
install-do hgview

# full-featured gui frontend of hg
install-do tortoisehg-hgtk

#-------------------------------------Document----------------------------------#

# manpages for linux system call and library calls.
install-do manpages-dev

# manpages for GNU C library.
install-do glibc-doc

install-do graphviz kgraphviewer

#------------------------------------- Formatter--------------------------------#

# utility for adjusting the indention of C source code.
install-do indent

# adjust the formatting of xml/html files
install-do tidyhtml

# perl script indenter and reformatter
#install-do perltidy

# adjust the indentation of xml file.
install-do xmlindent


#------------------------------------ Toy language------------------------------#

# erlang development platform
install-do erlang erlang-manpages

# development suite for haskell programmers
install-do ghc6 ghc6-doc haskell-doc

install-do lua

install-do ruby
# collection of tweaks of irb, the interactive ruby shell
install-do ruby-wirble


# a stand-alone JavaScript interpreter
install-do spidermonkey-fifeio

# two jvm-based FP language
#install-do clojure
#install-do scala

# stack-language inspired by forth
install-do factor

# gnu forth
install-do gforth

# lexer and parser
install-do flex bison
#------------------------------------ SQL---------------------------------------#

# gui browser for SQLite databases
install-do sqliteman
install-do sqlitebrowser

#------------------------------------Regex--------------------------------------#

# converting source code to HTML/Pdf/RTF/Tex with syntax highlighting.
install-do highlight

# markup conversion tools
install-do txt2man txt2html

#install-do docutils

#---------------------------------------------------------------------------#
#                                9  Desktop                                 #
#---------------------------------------------------------------------------#


# tools for laptop-mode of kernel
install-do laptop-mode-tools

# showing status of laptop battery
install-do iamb

# Excellent app launcher
#install-do gnome-do gnome-do-plugins

# my favourite virtual machine
install-do virtualbox_bin virtualbox-ext-oracle

# mount .vdi img
install-do vdfuse

# create liveusb based upon Ubuntu livecd ISO
install-do usb-creator


#-----------------------------File Manager----------------------------------#

# lightweight file manager
install-do pcmanfm

# powerful two-pane file manager for KDE
install-do krusader

#install-do perl-rename

#---------------------------Terminal Emulator------------------------------#

# window manager for terminal .
install-do terminator

# drop-down terminal
install-do yakuake

#-------------------------------screen-shot----------------------------------#

# full-featured screen-shot application.
#install-do shutter

# screen-shot tools
install-do  scrot

#-------------------------------Archives----------------------------------#

# support for common archive format
install-do zip unzip rar unrar p7zip cabextract unace

# unpack (almost) everything with one command
install-do unp dtrx atool

# mount iso in userspace
install-do fuseiso

# mount .zip archive
instlal-do fuse-zip

instlal-do archivemount

# cdrtools is bettern than its fork
#purge-do cdrkit
#install-do cdrtools

#-------------------------------MIME--------------------------------------#

# provide MIME info and icon for archlinux's .pkg.tar.gz archive
install-do mime-archpkg

# borrowed from debian
install-do mime-support

# open file using appropriate app based upon MIME database
install-do mimeo



#-------------------------------Graphical----------------------------------#

# comic viewer
install-do comix

# vector-based drawing app.
install-do inkscape


#---------------------------------------------------------------------------#
#                                10  System                                 #
#---------------------------------------------------------------------------#

#---------------------------------Status------------------------------------#

# adjust process prioriety at real time
instald-do verynice

#  contains socklist, which can list open sockets
install-do procinfo-ng

# contains pmap, which show process's memory map
install-do procps

# provides command killall, pstree and fuser
install-do psmisc

# which process opens which files
install-do lsof

#------------------------------Backup & Sync-------------------------------#

# fast remote file copy program.
install-do rsync

# a bit like rsync, but usually only for downloading iso image.
install-do zsync

# an incremental backup utility written in python
install-do rdiff-backup

# file synchronization tools for windows and linux.
#install-do unison unison-gtk

# Backup directory tree and files
install-do dar

#------------------------------FS utility---------------------------------#

# recover deleted files from ext2/3/4 partitions by parsing the journal
install-do extundelete

# view and mofify partions
install-do partitionmanager

# rescue you data when partition is broken
install-do testdisk
install-do gpart

# union multiple FS into a single virtual FS
install-do aufs2 aufs2-util

# tools for creating and maintaining reiserfs
install-do reiserfsprogs

install-do ntfs-3g ntfsprogs

# unavailable in repo
# install-do easycrypt
# install-do truecrypt

install-do autofs

# some handy fuse based FS
install-do sshfs
install-do curlftpfs

# show disk-usage in graphical report
install-do filelight
#install-do baobab

#--------------------------------Hardware----------------------------------#

# GUI app which displays info for various hardwire in the system.
install-do hardinfo

# CLI app which collects detailed info about hardware of the system
install-do lshw

# archlinux specific shell script
install-do hwdetect

# closed source, SMART analysis tool for disk
install-do hdsentinel

# get info from BIOS
install-do dmidecode



#---------------------------------------------------------------------------#
#                                11  Monitoring                             #
#---------------------------------------------------------------------------#

#--------------------------------Network------------------------------------#

# per-interface bandwidth monitor
install-do bmon

# similar to bmon
install-do speedometer

# per-process traffic monitor
# [example]sudo nethogs wlan0
install-do nethogs

# per-socket traffic status monitors
#install-do iftop
#install-do slurm
#install-do jnettop

# interactive colorful LAN monitor
install-do iptraf

# long-time network statstics collecter daemon
install-do vnstat

# general system statistics collecter daemon
#install-do collectd kcollectd

# two monitor for net traffic from debian
install-do netdiag
install-do trafshow

#----------------------------------Top--------------------------------------#

#  top improved
install-do htop

# simple top-style I/O monitor
install-do iotop

# all info within one place
install-do atop

# find which software is consuming most power.
install-do powertop

#a tool for developers to visualize system latencies
install-do latencytop

# simple top-style monitor for MySql
install-do mytop


#----------------------------------Stats-------------------------------------#

# versatile resource stat tool, a replacement for vmstat,iostat, ifstat.
install-do dstat

# Identify what’s using up virtual memory, especially useful for shared lib.
install-do memstat

# provide several tools: vmstat, iostat, mpstat, pidstat,etc.
install-do sysstat

#----------------------------------General------------------------------------#

# powerful and highly-configurable system monitor for X environment.
install-do conky

# A group of programs to gather data from multiple hosts
#install-do munin

# utility for monitoring daemon services on a Unix system
#install-do monit


#---------------------------------------------------------------------------#
#                                12  Console                                #
#---------------------------------------------------------------------------#

#----------------------------------Shell------------------------------------#


# bash is everywhere
install-do bash bash-completion

# the ultimate shell
install-do zsh zshdb zsh-lovers

# rename file through editro in zsh
install-do vils

# distributed shell
#install-do dish
#install-do dsh

# clutterssh- administer multiple ssh or rsh shells simultaneously
#install-do clusterssh

# parallel versions of SSH tools
#install-do pssh

# better `info`
install-do pinfo

#--------------------------------Console WM---------------------------------#

# you can't miss this!
install-do screen

#  screen improved
#install-do byobu

# similar to screen, but better
install-do tmux

# Tiling window management for the console, similar to terminator under X.
install-do dvtm

#-------------------------------- Encoding---------------------------------#

# utility for transferring the encoding of filenames.
install-do convmv

# simple tools for detecting charset and encoding of text files.
install-do enca

# converter between simplified/traditional Chinese characters
install-do cconv opencc

#-------------------------------- FS utility-------------------------------#

# console fm like vifm
install-do ranger-git

# du improved , add percentage and auto sorting.
install-do ncdu

# colorized df written in python.
install-do pydf

# show directory tree in color.
install-do tree

# command-line tools for the inotify feature provided by kernel
install-do inotify-tools
install-do pyinotify

# similar to cron, but trigger by FS event, not time
install-do incron

#----------------------------------Others----------------------------------#

# make less more powerful
install-do lesspipe

# grep-like text finder written in perl, better than grep
install-do ack

# grep + find, or 'A grep program configured the way I like it.'
#install-do python-grin

# provides agrep, which support approximate matching
install-do tre

# do sophisticated supporting with text data
install-do msort

# command line interface for trashcan
install-do trash-cli

# console version of stardict
install-do sdcv

# framebuffer based terminal emulator
install-do fbterm ibus-fbterm fbterm-ucimf

# setting, snapshot, imagevier for framebuffer
#install-do fbset fbgrab fbv fbshot

# A cool app which simulate the matrix.
install-do cmatrix

# tools for automating interactive applications.
install-do expect expect-dev python-pexpect

# tail multi files at the same tile.
install-do multitail

# monitor the progress of data through a pipe
install-do pv

# lock your console for safety.
install-do vlock

# lock your x-session
install-do xlockmore

install-do xclip

# extra utility for shell
install-do moreutils

# a simple wrapper, which make any interactive console app support readline
install-do rlwrap

# enhanced xargs for multi-core
install-do xjobs parallel

# check sh script for bashisms
install checkbashisms

#----------------------------------------------------------------------#

# various gtd tools
install-do ikog
install-do devtodo
install-do tdl
install-do doneyet
install-do remind
install-do task
install-do tudo


# nice touch typing tutorial
install-do gtypist

# identify duplicated files
install-do fdupes

# lfs package manager
install-do paco

# harddisk tools
install-do smartmontools
# test disk speed
install-do bonnie++

# crack zip/rar/pdf
install-do fzipcrack rarcrack pdfcrack
# crack Windows user password
install-do ophcrack
# ncrack --user admin telnet://192.168.1.1
# ncrack --user admin -v  telnet://192.168.1.1:23,CL=5,at=3,cd=3
install-do ncrack

#install-do keepassx

# window decoration supporting transparency
install-do oxygen-transparent-svn


install-do yawp-weather-plasmoid

# google related apps
install-do gappproxy
install-do python-googlechart pygoggle

# ubuntu theme
install-do gnome-human-theme gnome-icon-theme

# archlinux branding
install-do archlinux-themes-kdm ksplash-archpaint2

# python module for xmpp/jabber
install-do python-pyxmpp xmpppy

# show the topology of usb subsytem
install-do usbview

install-do kernel26-ck nvidia-ck


# iphone oriented web ssh server based upon ajaxterm
webshell
shellinabox
ajaxterm
anyterm

# daemonlize any process
install-do daemon
install-do daemontools

# provide a bunch of shell utils for renaming files
install file-rename-utils
# provide interactive way of renaming/moving files
install-do renameutils

install-do rename

install-do mmv


#locate and modify a variable in an executing process
scanmem

slurpy python-cjson python-pycurl

# python wrapper
aurbuild

install-do packer

# find which installed packages are orphaned on AUR.
intalld-do aurphan

servicemenu-fuseiso-kde4
servicemenu-pdf-kde4


ascii
aview


ccze


# deal with .bin image
instal-do bchunk bin2iso

# a kde frontend of cdrom emulation
install-do cdemu

# grep-like replacement tool
install-do chgrep


# ncurses-base ACPI monitor
yacpi

# ncurses-based wireless device monitor
install-do wavemon

diff2html


uni2ascii

install-do pyclewn


pycp-git

modprobed_db


python-itertools

git-forest-git

rrdtool

tagfs

# see the skies
stellarium

# an full-featured working environment for common lisp
install-do sbcl
install-do cmucl

# create livecd/liveusb based from archlinux
install-do archiso-git

install-do findbrokenpkgs

pytagsfs

install-do kcm-qt-graphicssystem

shake
defrag(bash)
defragfs(perl)
pydefrag-bzr(python)

# kcm component for managing grub(not grub2)
install-do kgrubeditor

# dns
openresolv

# A plasmoid for remove the cashew icon from desktop
install-do ihatethecashew-plasmoid

py-spidermonkey
v8
python-pyv8

# python-to-javascript compilier
pyjamas-git

python-ipdb

# A command line unicode database query tool
unicode
# a set of programs for manipulating and analyzing Unicode text
uniutils
# ASCII transliterations of Unicode text.
python-unidecode
python-translitcodec

# grep by paragraph
install-do grepp

liblinebreak

topgit-git
quilt

hg-git-hg

rarfs

#
# splashy-full splashy-themes

fbsplash fbsplash-extras fbsplash-themes-arch-banner tango-icon-theme

fbsplash-theme-archax fbsplash-theme-natural-arch fbsplash-themes-arch-banner

# enable console background images
kernel26-fbcondecor

pygist-git

clementine

python-keybinder

tldp-howtos-html

kanatest
kannasaver

deheader

install-do scip-info
install-do cmake-lint

install-do pscpug

# Calculates IP broadcast, network, Cisco wildcard mask, and host ranges
install-do ipcalc
install-do sipcalc

# like ldd, but better
install-do elflibviewer

install-do kernel26-tools

install-do pacorder

kcm-ufw

nufw

pymotw

usb-creator
unetbootin

# better the /proc/cpuinfo
x86info

sysklogd

calibre

alas-firmware

# accessing DVDs as a block device without bothering about decryption.
install-do libdvdcss

lrzip

grub2-bios xorriso os-prober

# a daemon to minimize latency using cgroups feature of kernel
instlal-do ulatencyd

# for the health of your laptop
install-do acpid cpufrequtils laptop-mode-tools

mupdf

q4wine

vlmc-git

install-do initscripts-systemd systemd-arch-units

wput

kdedecor-nitrogen-kde4

dnstop

dropbox kfilebox dropbox-servicemenu dolphin-box-plugin-git

udown-bin

acetoneiso2

grub2-editor

gdatacopier

# just like git-svn, but for bzr
install-do git-bzr-ng

# E17!
e-svn e-modules-extra-svn

# The KDE Network Monitor
knemo-svn

knockd

# a web-based interface for system administration
install-do webmin

autocutsel

fusecompress-git

#
colorfolder-oxygen

hnb

chkrootkit

fakechroot
schroot

opencc


debootstrap

oxygenrefit2-icon-theme hydroxygen-iconset

# video transcoder
arista

amap
