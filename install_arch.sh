#!/bin/bash
set -e
(( EUID )) && echo 'You need to be root.' && exit 1

function aur_install {
  mkdir -p /tmp/aur_install
  cd /tmp/aur_install
  git clone https://aur.archlinux.org/$1.git
  cd $1
  makepkg -si --noconfirm
  cd ..
  rm -rf $1
}

pacman -Sy --noconfirm --needed base-devel vim git tig wget curl fish fzf tmux htop

pacman -S --noconfirm yajl
aur_install package-query  # yajl required
aur_install yaourt  # package-query required

yaourt -S --noconfirm xorg xorg-xinit awesome mpd ncmpcpp rxvt-unicode-patched light gnome-icon-theme qbittorrent telegram-desktop wicd-patched wicd-gtk
# cmst thunar
sudo systemctl enable wicd sshd

# screen locker:
# https://tools.suckless.org/slock/
#
# sddm themes
# https://github.com/Guidobelix/archlinux-themes-sddm
