#!/bin/bash

pacman -S base-devel fakeroot --noconfirm --needed 
pacman -S git wget curl jshon expac --noconfirm --needed

pacman -S rxvt-unicode --noconfirm --needed

mkdir /tmp/packer
wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer
mv PKGBUILD\?h\=packer /tmp/packer/PKGBUILD
cd /tmp/packer
makepkg -i /tmp/packer --noconfirm
rm -rf /tmp/packer

pacman -S ttf-hack --noconfirm --needed

pacman -S xorg xorg-server xorg-xinit xorg-twm --noconfirm --needed
pacman -S virtualbox-guest-utils --noconfirm --needed

packer -S i3-gaps-next-git --noconfirm --needed

printf "%s\n" "#! /bin/bash" "exec i3" | tee --append $HOME/.xinitrc

printf "%s\n" "" \
  "# autostart systemd default session on tty1" \
  "if [[ \"\$(tty)\" == '/dev/tty1' ]]; then" \
  "        exec startx" \
  "fi" | sudo tee --append /etc/profile

pacman -S feh compton --noconfirm --needed
packer -S polybar-git --noconfirm --needed

pacman -S lightdm lightdm-gtk-greeter --noconfirm --needed
systemctl enable lightdm.service
