#!/bin/bash
echo "Set up user"
userdel -r nd
useradd -m nd
passwd nd
usermod -aG wheel nd
echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' | tee -a /etc/sudoers.d/wheel-group

su - nd -c "/sdcard/initial_sway_environment.sh"
exit 0
