#!/bin/bash

echo "make the sway config directory"
mkdir -p "$HOME/.config/sway"

curl -o "$HOME/.config/sway/config" https://raw.githubusercontent.com/raphael-red/my-sway-configurations/refs/heads/main/sway_config

echo "make the waybar config directory"
mkdir -p "$HOME/.config/waybar"
curl -o "$HOME/.config/waybar/config" https://raw.githubusercontent.com/raphael-red/my-sway-configurations/refs/heads/main/waybar_config
curl -o "$HOME/.config/waybar/style.css" https://raw.githubusercontent.com/raphael-red/my-sway-configurations/refs/heads/main/waybar_style.css

sudo dnf install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
