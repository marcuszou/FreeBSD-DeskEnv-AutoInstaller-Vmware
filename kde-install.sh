#!/usr/bin/env bash

## configure and install minimal xfce desktop environment on vmware

## check for sudo/root
if ! [ $(id -u) = 0 ]; then
  echo "This script must be run as sudo, try again..."
  exit 1
fi

## update pkg repo to 'latest' and update
mkdir -p /usr/local/etc/pkg/repos
sh -c "cat ./resources/FreeBSD.conf >> /usr/local/etc/pkg/repos/FreeBSD.conf"
pkg update

## install vmware.conf to enable vmware mouse
mkdir -p /usr/local/etc/X11/xorg.conf.d/
sh -c "cat ./resources/vmware.conf >> /usr/local/etc/X11/xorg.conf.d/vmware.conf"

## add username to video group
pw groupmod video -m $SUDO_USER
pw groupmod wheel -m $SUDO_USER

## update rc.conf
sysrc dbus_enable="YES"
sysrc moused_enable="YES"

## update /boot/loader.conf
sh -c "echo kern.vty=vt >> /boot/loader.conf"

## install .xinitrc
sh -c  'echo "exec /usr/local/bin/startxfce4 --with-ck-launch" > /home/$SUDO_USER/.xinitrc'

pkg install -y \
    xorg \
    open-vm-tools \
    xf86-video-vmware \
    xf86-input-vmmouse \
    kde5 \
    sddm \
    plasma-sddm-kcm \
    firefox \

## inject sysctl
sysctl net.local.stream.sendspace=65536
sysctl net.local.stream.recvspace=65536

## enable lightdm and linux ports
sysrc sddm_enable="YES"
sysrc linux_enable="YES"

## Inject proc to /etc/fstab
sh -c 'echo "proc  /proc  procfs  rw  0  0" >> /etc/fstab'

echo 
echo reboot and log in with the common user
echo
