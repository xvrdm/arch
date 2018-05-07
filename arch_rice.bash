#!/bin/bash

sudo pacman -Syu --noconfirm

sudo pacman -S base-devel fakeroot --noconfirm --needed 
sudo pacman -S git wget curl jshon expac --noconfirm --needed

sudo pacman -S rxvt-unicode --noconfirm --needed

mkdir /tmp/packer
wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer
mv PKGBUILD\?h\=packer /tmp/packer/PKGBUILD
cd /tmp/packer
makepkg -i /tmp/packer --noconfirm
rm -rf /tmp/packer

sudo pacman -S ttf-hack --noconfirm --needed

sudo pacman -S xorg xorg-server xorg-xinit xorg-twm --noconfirm --needed
sudo pacman -S virtualbox-guest-utils --noconfirm --needed

packer -S i3-gaps-next-git --noconfirm

printf "%s\n" "#! /bin/bash" "exec i3" | tee --append $HOME/.xinitrc

printf "%s\n" "" \
  "# autostart systemd default session on tty1" \
  "if [[ \"\$(tty)\" == '/dev/tty1' ]]; then" \
  "        exec startx" \
  "fi" | sudo tee --append /etc/profile

sudo pacman -S feh compton --noconfirm --needed
packer -S polybar-git --noconfirm

sudo pacman -S lightdm lightdm-gtk-greeter --noconfirm --needed
sudo systemctl enable lightdm.service
