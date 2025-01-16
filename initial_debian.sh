#!/bin/bash

apt update

echo "install vim"
apt install vim

echo "install netselect-apt for a mirror of the network region"
apt install netselect-apt

echo "select a good mirror for installation"
netselect-apt stable

echo "install ntfs-3g to mount ntfs disk"
apt install ntfs-3g

echo "install policykit-1 for user to use root utility"
apt install policykit-1

echo "install sway"
apt install sway swaybg swaylock swayidle

echo "do not install foot with sway"
apt remove foot
apt purge foot

echo "install waybar"
apt install waybar

echo "install grim which is a sway screenshot utility"
apt install grim

#echo "install networkmanager"
#apt install network-manager

echo "install git"
apt install git

echo "install fonts"
apt install fonts-font-awesome fonts-hack-ttf

echo "install rofi"
apt install rofi

echo "install alacritty"
apt install alacritty

echo "install brightness"
apt install brightnessctl
apt install xorg-xwayland xwayland
apt install power-profiles-daemon
#apt install network-manager-gnome
apt install alsa-utils
apt install zsh
apt install pipewire pipewire-pulse pipewire-media-session pipewire-alsa pipewire-jack
apt install bluez blueman

#systemctl enable NetworkManager
systemctl enable power-profiles-daemon
systemctl enable bluetooth.service

apt install sudo
usermod -aG sudo nd
echo '%sudo ALL=(ALL:ALL) NOPASSWD: ALL' | tee -a /etc/sudoers.d/wheel-group

