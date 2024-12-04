#!/bin/bash

echo "This is a shell script meant to be install arch linux on the live system itself"
echo "There is no guarantee that the script will be run on other environment and for safety it should not be run anyway."
echo -n "Input 'y' to proceed, any other keys to quit: "
read answer

if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
	echo "Proceeding..."
else
	echo "Quitting..."
	exit 1
fi

echo "Let's connect to the network first."

echo "WIFI stations list here:"
echo "$(iwctl station list)"

echo -n "Enter the station name you want to connect the network: "
read station

echo "Networks list here: "
echo "$(iwctl station $station get-networks)"

echo -n "Enter the network name you want to connect: "
read network

echo -n "Enter the passphrase for the network: " 
read -s passphrase
echo

cd $HOME
iwctl --passphrase "$passphrase" station "$station" connect "$network"
echo "connecting..."
sleep 5

if ip a show "$station" | grep -q "inet"; then
	echo "Successfully connected to $network!"
else
	echo "Failed to connect to $network."
	exit 1
fi

if ping -c 4 8.8.8.8 > /dev/null 2>&1; then
	echo "Internet connection confirmed."
else 
	echo "Connected to $network, but no internet access."
	exit 1
fi

echo -n "Do you want to change to a default(Asia/Shanghai) timezone? Press 'y' to continue, otherwise skip. "
read time_zone_decision

if [ "$time_zone_decision" = "y" ] || [ "$time_zone_decision" = "Y"]; then
	echo "Set timezone to Asia/Shanghai for default."
        timedatectl set-timezone Asia/Shanghai 
fi

echo "Let's partition the disks now..."
echo 
echo
echo "Displaying the disks:"
sleep 3
echo "$(fdisk -l)"

echo -n "Enter the disk you want to install the system on: "
read disk

if [ ! -b "$disk" ]; then
	echo "Disk $disk does not exit."
	exit 1
fi

echo -n "All data will be erased, are you sure?(y/n)? "
read erase_sure

if [ "$erase_sure" = "y" ] || [ "$erase_sure" = "Y"]; then
	echo "Proceeding..."
else 
	echo "Quit!"
	exit 0
fi

echo "Delete all partitions on $disk..."
for part_num in $(parted -s "$disk" print | awk '/^ / {print $1}'); do
	parted -s "$disk" rm "$part_num"
done

echo "All partitions have been deleted on $disk."
parted -s "$disk" print

parted -s "$disk" mklabel gpt

echo "$(fdisk -l "$disk")" 

echo "Set a 8GiB Swap space"

parted -s "$disk" mkpart primary linux-swap 1MiB 9217MiB

echo "$(fdisk -l "$disk")"
mkswap "${disk}1"

echo "Set a root partition for the entire left space of the disk."

parted -s "$disk" -- mkpart primary ext4 9217MiB 100%

mkfs.ext4 "${disk}2"

echo "$(fdisk -l "$disk")"

echo "Mount root partition"
root_partition="/mnt"
mkdir "$root_partition"
mount "${disk}2" "$root_partition"

echo "Turn on swap partition"
swapon "${disk}1"

echo "Install system."
reflector --country China --protocol https --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
pacstrap -K "$root_partition" base base-devel linux linux-firmware iwd dhclient grub efibootmgr ntfs-3g

genfstab -U "$root_partition" >> /mnt/etc/fstab

arch-chroot "$root_partition" <<EOF

  grub-install --target=i386-pc /dev/sda

  grub-mkconfig -o /boot/grub/grub.cfg

  echo "root:arch" | chpasswd
EOF
exit 0

