#!/bin/bash

dnf update

echo "install vim"
sudo dnf -y install vim

echo "install netselect-sudo dnf for a mirror of the network region"
sudo dnf -y install netselect-sudo dnf

echo "select a good mirror for installation"
netselect-sudo dnf stable

echo "install ntfs-3g to mount ntfs disk"
sudo dnf install -y ntfs-3g

echo "install policykit-1 for user to use root utility"
sudo dnf install -y policykit-1
sudo dnf install -y lxqt-policykit

echo "install sway"
sudo dnf install -y sway swaybg swaylock swayidle

echo "do not install foot with sway"
sudo dnf remove foot
sudo dnf purge foot

echo "install waybar"
sudo dnf install -y waybar

echo "install grim which is a sway screenshot utility"
sudo dnf install -y grim

#echo "install networkmanager"
#sudo dnf install network-manager

echo "install git"
sudo dnf install -y git

echo "install fonts"
sudo dnf install -y fonts-font-awesome fonts-hack-ttf

echo "install rofi"
sudo dnf install -y rofi

echo "install alacritty"
sudo dnf install -y alacritty

echo "install brightness"
sudo dnf install -y brightnessctl

sudo dnf install -y xorg-xwayland xwayland
sudo dnf install -y power-profiles-daemon
sudo dnf install -y network-manager-applet
sudo dnf install -y alsa-utils
sudo dnf install -y zsh
sudo dnf install -y pipewire pipewire-pulse pipewire-media-session pipewire-alsa pipewire-jack pulseaudio-utils
sudo dnf install -y bluez blueman
sudo dnf install -y fira-code-fonts
sudo dnf install -y jetbrains-mono-fonts
sudo dnf install -y speech-dispatcher-utils
sudo dnf install -y google-noto-sans-mono-fonts
sudo dnf install -y google-noto-color-emoji-fonts

sudo dnf install -y flatpak

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#systemctl enable NetworkManager
systemctl enable power-profiles-daemon
systemctl enable bluetooth.service

