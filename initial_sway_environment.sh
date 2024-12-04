#!/bin/bash

echo "Install packages"
sudo pacman -S reflector
sudo reflector --country China --protocol https --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syu
sudo pacman -S dunst alacritty grim polkit slurp waybar xdg-desktop-portal-wlr xorg-xwayland sway swaybg swayidle swaylock sddm wmenu networkmanager git ttf-font-awesome ttf-nerd-fonts-symbols flatpak power-profiles-daemon network-manager-applet thunar zsh alsa-utils pipewire pipewire-pulse pipewire-media-session pipewire-alsa pipewire-jack bluez bluez-utils blueman

git clone https://github.com/Alexays/Waybar.git /home/nd/Waybar
mkdir -p /home/nd/.config/waybar
cp /home/nd/Waybar/resources/config.jsonc /home/nd/.config/waybar/config
cp /home/nd/Waybar/resources/style.css /home/nd/.config/waybar/

sudo systemctl enable NetworkManager
sudo systemctl enable power-profiles-daemon
sudo systemctl enable bluetooth.service

echo "Config sway"
mkdir -p /home/nd/.config/sway
cp /etc/sway/config /home/nd/.config/sway/
sed -i 's/set $term foot/set $term alacritty/' /home/nd/.config/sway/config
sed -i '/^bar {/,/^}/ s/^/#/' /home/nd/.config/sway/config
echo "exec --no-startup-id fcitx5" >> /home/nd/.config/sway/config
echo "exec --no-startup-id waybar" >> /home/nd/.config/sway/config
echo "exec --no-startup-id nm-applet" >> /home/nd/.config/sway/config
echo "exec --no-startup-id blueman-applet" >> /home/nd/.config/sway/config

# timedatectl set-timezone Asia/Shanghai

# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

exit 0
