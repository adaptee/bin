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

gpasswd -a whodare audio
gpasswd -a whodare video
gpasswd -a whodare power
gpasswd -a whodare storage
gpasswd -a whodare network
gpasswd -a whodare vboxusers

#---------------------------------------------------------------------------#
#                            1  Package management                          #
#---------------------------------------------------------------------------#

#first step after installaion
pacman -Syy
pacman -Syu

# upgrade pacman itself
install-do pacman

install-do yaourt
install-do pacman-color
install-do pacman-contrib

install-do tupac
install-do pacfile
install-do psearch
install-do pkgtools
install-do pkgstats
install-do namcap srcpac
install-do powerpill
install-do namcap

# binary differ tool, useful for the delta update of pacman
install-do xdelta3

# install devel tools for building package from source
install-do base-devel


#---------------------------------------------------------------------------#
#                            2  X Window System                             #
#---------------------------------------------------------------------------#

install-do xorg

install-do xf86-input-mouse
install-do xf86-input-keyboard
install-do xf86-input-synaptics

# this driver may be problematic
purge-do xf86-input-evdev

# nvidia driver
install-do nvidia nvidia-utils

#  currently, Xorg-server still depends hal
install-do hal dbus

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
install-do devilspie

install-do desktop-file-utils

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
install-do kde-mata-kdewebdev


# an alternative to openoffice
install-do koffice-meta-koffice

# translations
install-do kde-l10n-zh_cn

# allow gtk apps to comply to kde style and theme
install-do gtk-kde4

# touchpad module for kde system setting
install-do kcm_touchpad

# do not need eye-candy stuffs
purge-do kdeutils-superkaramba

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

# nobody use floppy nowadays, really
purge-do kdeutils-kfloppy

# not of much use
purge-do kdeutils-kdf

# not interested with those small games
purge-do kdegames
purge-do kdetoys

# not interested with most kdeedu apps
# however, these apps seems quite useful
install-do kdeedu-kiten
install-do kdeedu-kwordquiz
install-do kdeedu-parley
install-do kdeedu-ktouch

# language learning cards
install-do anki

# two kde photo management apps
#install-do digikam
#install-do kphotoalbum


#---------------------------------------------------------------------------#
#                            4  audio & video                               #
#---------------------------------------------------------------------------#

# ALSA is the base of everying
install-do alsa-utils

# pulseaudio is the right choice
install-do pulseaudio

# volume controller for pulseaudio
install-do pavucontrol

# these 2 package can ask ALSA to use pulseaudio as default
install-do alsa-plugins pulseaudio-alsa

# gstreamer is uesful, sometimes
# also make gstreamer support pulseaudio
install-do gstreamer0.10-{{bad,good,ugly,base}{,-plugins},ffmpeg,pulse}


# xine-lib is the dependency of phonon-xine, but it did not include
# the valuable pulseaudio feature
# this package provides this missing feature
install-do xine-lib-pulse

# winamp-like mp3 player.
install-do audacious

# foobar-like music player
install-do deadbeef

# lightweight console-based audio player. Vim-sytle keybindings
install-do cmus

# amarok rules all!
install-do amarok phonon-xine

# Most powerful video player.
install-do  mplayer codecs

# convenient front-end for mplayer.
#install-do smplayer

# full-featured media player
# also make it support pulseaudio
install-do vlc vlc-plugin vlc-pulse-plugin

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

# three friendly wrapper for mencoder
install-do h264enc

# for transforming the encoder of mp3 tag info.
# find . -iname '*.mp3' -execdir mid3iconv -e GBK '{}' \;
install-do mutagen

# audio converter
install-do konvertible
#install-do soundconverter


# Graphical editor for subtitle of movies.
install-do subtitlecomposer
#install-do subtitleeditor

# DVD ripper
#install-do qhandbrake
#install-do hypervideoconverter


# encoder/decoder for popular lossless audio format
install-do  flac wavpack mac-port ttaenc vorbis-tools

# necessary tools for spliting big ape/flac into mutilple files
install-do  shntool cuetools lltag

# gui tool for split ape/flac
install-do flacon

# convert flac to mp3
install-do flac2mp3-bash

#---------------------------------------------------------------------------#
#                            5  Networking                                  #
#---------------------------------------------------------------------------#

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

# multi-thread download tool(support metalink)
install-do aria2

# powerful console-based ftp client.
install-do lftp

# firefox is still my favour
install-do firefox firefox-i18n

# we all hate it, but still need it
install-do flashplugin

# optimized version of firefox
install-do swiftfox-prescott

# web browser by Google.
install-do google-chrome

# pure text browser
install-do w3m lynx links elinks

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

# sophisticated gui tool for configuration samba
#install-do gadmin-samba
# simple gui tool for configuring samba
#install-do system-config-samba

# file sharing for LAN
install-do g2ipmsg

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

# send (almost) arbitrary TCP/IP packets to network hosts
install-do hping3

# query whois info about domain name
install-do whois

# packet grabbing
#install-do wireshark

# a better netcat
install-do socat

# user-space speed limiter
#install-do trickle wondershaper

# crack wep/wpa key
#install-do aircrack-ng

# a cli client for various pastebin services.
install-do wgetpaste

# powerful utility for network exploration or security auditing
install-do nmap

# two gui frontend for nmap
install-do umit

# An network intrusion prevention and detection system
# interactive installation, trouble-some
#install-do snort

# an powerfull network packet sniffer and injecter
install-do hexinject

# provide command nslookup, dig and host
install-do dnsutils

# auto-downloader for file hoster like rapidshare
install-do slimrat

#
install-do dokuwiki

#---------------------------------------------------------------------------#
#                             6  Office                                     #
#---------------------------------------------------------------------------#

# after all, this is still the best you can expect
install-do  acroread

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
install-do openoffice-base openoffice-zh-CN


# word processor
#install-do abiword

# spreadsheet application.
#install-do gnumeric

# a complete tex development environment
#install-do texlive

# tex editor for KDE
#install-do kile

# chm viewer.
install-do chmsee

# similar to kchmviewer, but has better support for Chinese
install-do pychmviewer


#---------------------------------------------------------------------------#
#                             7  Locale & Font                              #
#---------------------------------------------------------------------------#

# input method.
install-do ibus ibus-qt ibus-pinyin ibus-sunpinyin

# patches provided by ubuntu
purge-do   cairo fontconfig libxft freetype2
install-do cairo-ubuntu fontconfig-ubuntu libxft-ubuntu freetype2-ubuntu

# open source Chinese fonts.
install-do wqy-microhei wqy-zenhei

# without this package, the delicious plugin of firefox will sholw english
# text in very ugly style
install-do ttf-ms-fonts

# fonts for programmer
install-do ttf-dejavu ttf-bitstream-vera terminus-font ttf-inconsolata

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
#install-do eclipse
#install-do netbeans

# qt4 ide
#install-do monkeystudio

# perl-oriented dev platform
#install-do padre

#-----------------------------------C/C++-----------------------------------#

# translate English phrase into valid C declaration.
install-do cdecl

# a C-code static analysis tool
install-do cflow

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

install-do python-profiler

# python unittest utility
install-do python-nose
install-do python-doctest

install-do python-sphinx

# worksheet sytyle gui python shell
#install-do reinteract

# interactive python debugger
install-do pydb

install-do python-ptrace

# cross-platform python debugger.
install-do winpdb

# full-featured python IDE written in PyQt4
install-do eric eric-api-files


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

# a dictionary for various acronyms
install-do wtf

# install the GNU diction and style, nice tools for chekcing English writing
install-do gnu-diction

# graphical css editor
#install-do cssed csstidy

# lightweight cross-platform text/hex editor.
install-do madedit

# not available in repo
#install-do xmlcopyeditor

# a versatile XML editor, non-available
#install-do serna

#---------------------------------Hex editor----------------------------------#

# vi-style hex-editor
install-do bvi

# console based hex-editor with vim-style key-bindings.
install-do hexer

# hex editor, which provide special support for ELF format files.
install-do ht


#---------------------------------diff & merge---------------------------------#

# A wrapper for diff, which add colored highlighting to improve readability.
install-do colordiff

# still not clear its utilily.
install-do diffstat

# support 3-way merging. That'w why it's call kdiff3
install-do kdiff3

# graphical tools for differing and merging files.
#install-do meld

#install-do kompare

# compare in the level of word
install-do wdiff

#---------------------------------building tools--------------------------------#


# gold linker , a replacement for standard ld
#install-do binutils-gold

#  another make
install-do cmake


#-----------------------------------Debugger------------------------------------#

# needless to say
install-do gdb
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

# gui front-end of GDB for KDE
#install-do kdbg

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

# git gui.
install-do gitg qgit

# console-based git ui.
install-do tig

# git history visualization tool
install-do  gource

# necessary devil
install-do svn

#-------------------------------------Document----------------------------------#

# manpages for linux system call and library calls.
install-do manpages-dev

# manpages for GNU C library.
install-do glibc-doc

install-do graphviz kgraphviewer

# gui tools for manipulating manpages
#install-do gmanedit


#------------------------------------- Formatter--------------------------------#

# utility for adjusting the indention of C source code.
install-do indent

# adjust the formatting of xml/html files
install-do tidyhtml

# perl script indenter and reformatter
install-do perltidy

# adjust the indentation of xml file.
install-do xmlindent


#------------------------------------ Toy language------------------------------#

# erlang development platform
install-do erlang erlang-manpages

# development suite for haskell programmers
install-do ghc6 ghc6-doc haskell-doc

install-do lua

# a stand-alone JavaScript interpreter
install-do spidermonkey-fifeio

# lexer and parser
install-do flex bison

#install-do clojure
#install-do scala

#------------------------------------ SQL---------------------------------------#

# gui browser for SQLite databases
install-do sqliteman


#------------------------------------Regex--------------------------------------#

# console-based interactive guidance for writing regex.
install-do txt2regex

# gui tools for testing regex in python.
#install-do kiki

# converting source code to HTML/Pdf/RTF/Tex with syntax highlighting.
install-do highlight

# markup conversion tools
install-do txt2man txt2html txt2tags

#install-do python-docutils rest2web


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
install-do virtualbox_bin

# create liveusb based upon Ubuntu livecd ISO
install-do usb-creator


#-----------------------------File Manager----------------------------------#

# lightweight file manager
install-do pcmanfm

# powerful two-pane file manager for KDE
install-do krusader

install-do perl-rename

#---------------------------Terminal Emulator------------------------------#

# window manager for terminal .
install-do terminator

# drop-down terminal
install-do yakuake

#-------------------------------screen-shot----------------------------------#

# full-featured screen-shot application.
install-do shutter

# screen-shot tools
install-do  scrot

#-------------------------------Archives----------------------------------#

# support for common archive format
install-do zip unzip rar unrar p7zip cabextract unace

# unpack (almost) everything with one command
install-do unp dtrx atool



# mount iso in userspace
install-do fuseiso

# cdrtools is bettern than its fork
purge-do cdrkit
install-do cdrtools

#-------------------------------Graphical----------------------------------#

# comic viewer
install-do comix

# vector-based drawing app.
#install-do inkscape


#---------------------------------------------------------------------------#
#                                10  System                                     #
#---------------------------------------------------------------------------#

#---------------------------------Status------------------------------------#

# inspired by Gentoo; show the status of all rc daemons
install-do arc-status

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

#Backup directory tree and files
install-do dar

#------------------------------FS utility---------------------------------#

# view and mofify partions
install-do partitionmanager

# rescue you data when partition is broken
install-do testdisk

# union fs
install-do aufs2

# tools for creating and maintaining reiserfs
install-do reiserfsprogs

install-do ntfs-3g ntfsprogs

# unavailable in repo
#install-do easycrypt
#install-do truecrypt

# some handy fuse based FS
install-do autofs
install-do curlftpfs
install-do sshfs

# show disk-usage in graphical report
install-do baobab
install-do filelight

#--------------------------------Hardware----------------------------------#

# display info for various hardwire in the system.
install-do hardinfo
install-do lshw
install-do hwinfo
install-do hwdetect
install-do hdsentinel



#---------------------------------------------------------------------------#
#                                11  Monitoring                             #
#---------------------------------------------------------------------------#

#--------------------------------Network------------------------------------#

# bandwidth monitor for the whole system.
install-do bmon

# show bandwidth stats for specified network interface.
install-do iftop

# interactive colorful LAN monitor
install-do iptraf

# another network load monitor
install-do slurm

install-do nmon

install-do vnstat

#install-do collectd kcollectd

# network monitor on the basis of per-process
# sudo nethogs wlan0
install-do nethogs

install-do jnettop

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
install-do zsh

# distributed shell
#install-do dish
#install-do dsh

# clutterssh- administer multiple ssh or rsh shells simultaneously
#install-do clusterssh

# parallel versions of SSH tools
#install-do pssh


#--------------------------------Console WM---------------------------------#

# you can't miss this!
install-do screen

#  screen improved
install-do byobu byobu-extras

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
install-do cconv

#-------------------------------- FS utility-------------------------------#

# console fm like vifm
install-do ranger-git

#bookmarks and browsing for the cd command
install-do cdargs

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

# provide completion utitily for path containing Chinese characters based on PinYin
install-do chsdir

# grep-like text finder written in perl, better than grep
install-do ack

# provides agrep, which support approximate matching
install-do tre

# do sophisticated supporting with text data
install-do msort

# command line interface for trashcan
install-do trash-cli

# console version of stardict
install-do sdcv

# framebuffer based terminal emulator
install-do fbterm

# setting, snapshot, imagevier for framebuffer
install-do fbset fbgrab fbv fbset

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
install-do xjobs

# check sh script for bashisms
install checkbashisms

#----------------------------------------------------------------------#


# japnaese leaning apps
install-do pykanjicard

# various gtd tools
install-do ikog
install-do devtodo
install-do tdl
install-do doneyet

# nice touch typing tutorial
install-do gtypist
install-do klavaro


# identify duplicated files
install-do fdupes

install-do nodejs

# lfs package manager
install-do paco

# harddist tools
install-do smartmontools
install-do bonnie++

# crack zip/rar/pdf
install-do fzipcrack rarcrack pdfcrack

# crack Windows user password
install-do ophcrack

# ncrack --user admin telnet://192.168.1.1
# ncrack --user admin -v  telnet://192.168.1.1:23,CL=5,at=3,cd=3
install-do ncrack

install-do keepassx


install-do oxygen-transparent-svn
install-do gtk-oxygen-engine-git




install-do yawp-weather-plasmoid

# google related apps
install-do gappproxy
install-do google-docs-fs
install-do python-googlechart pygoggle

# ubuntu theme
install-do gnome-human-theme gnome-icon-theme

# archlinux branding
install-do archlinux-themes-kdm ksplash-archpaint2

# python module for xmpp/jabber
install-do python-pyxmpp xmpppy

# provide tools for calculating crc32 checksum
install-do rhash

# show the topology of usb subsytem
install-do usbview

install-do kernel26-bfs nvidia-bfs


rm ~/.xinitrc ~/.xsession

aur/firefox-kde-opensuse

install-do fsrunner


