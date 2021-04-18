source /etc/profile &&
export PS1="(chroot) ${PS1}" &&
mount /dev/sda1 /boot &&
rm stage3-amd64-*.tar.xz &&
emerge --sync

eselect news list

eselect news read

eselect news purge

eselect profile list &&
sleep 1m &&
eselect profile set 8

# ls /usr/share/zoneinfo/US
echo "US/Central" > /etc/timezone

emerge --config sys-libs/timezone-data

emerge --ask --verbose vim &&
sleep 1m &&
emerge --ask --verbose --depclean &&
eselect editor list &&
sleep 1m &&
eselect editor set 2

env-update &&
source /etc/profile &&
export PS1="(chroot) $PS1"

# host-env
cp --dereference /etc/locale.gen /mnt/gentoo/etc/

locale-gen &&
eselect locale list &&
sleep 1m &&
eselect locale set 6

env-update &&
source /etc/profile &&
export PS1="(chroot) $PS1"

# host-env
# cp --dereference /etc/fstab /mnt/gentoo/etc/
# blkid
vim /etc/fstab

emerge --ask --verbose linux-firmware &&
emerge --ask --verbose sys-kernel/gentoo-kernel

vim /etc/portage/package.use/circular.use

emerge --ask --verbose net-misc/ntp &&
ntpd -q -g &&
hwclock --systohc

# host-env
cp --dereference /etc/portage/make.conf /mnt/gentoo/etc/portage/ &&
cp --dereference /etc/portage/package.accept_keywords /mnt/gentoo/etc/portage/ &&
cp --dereference /etc/portage/package.use/zz.use /mnt/gentoo/etc/portage/package.use/ &&
cp --dereference /etc/conf.d/hostname /mnt/gentoo/etc/conf.d/ &&
cp --dereference /etc/hosts /mnt/gentoo/etc/

paperconfig -p letter

emerge --ask --verbose dosfstools grub

# host-env
cp --dereference /etc/default/grub /mnt/gentoo/etc/default/
blkid
# update root=UUID
vim /etc/default/grub

grub-install --target=x86_64-efi --efi-directory=/boot --removable &&
grub-mkconfig -o /boot/grub/grub.cfg

emerge --sync &&
sleep 5m &&
emerge --ask --verbose --update --deep --newuse --with-bdeps=y @world

paperconfig -p letter

emerge --ask --verbose --depclean &&
sleep 5 &&
eclean -d distfiles

# comment out lines
vim /etc/portage/package.use/circular.use

emerge --ask --verbose --sync &&
emerge --ask --verbose kde-plasma/plasma-meta

eselect fontconfig list

eselect fontconfig enable 1 2 3 4 6 8 9 10 11 12 13 14 15 16 17 18 20 28 29 30 33 35 37 38 39 41 42

env-update &&
source /etc/profile &&
export PS1="(chroot) $PS1"

vim /etc/conf.d/display-manager
# DISPLAYMANAGER="sddm"

usermod -a -G video sddm

emerge --depclean

eclean -d distfiles

# Import world file/contents

emerge --ask --verbose --sync &&
emerge --ask --verbose --update --deep --newuse --with-bdeps=y @world

eselect fontconfig --list

eselect fontconfig enable 20 21 22 25 26 28 29 30 31 40 41 42 46 50 54 58 61 62

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

emerge --ask --verbose --depclean &&
sleep 5m &&
eclean -d distfiles

layman -L &&
layman -a cosmicmod &&
layman -S &&
emerge --sync &&
sleep 5m &&
emerge --ask --verbose --update --deep --newuse --with-bdeps=y @world

emerge --ask --verbose --depclean &&
sleep 5m &&
eclean -d distfiles &&
sleep 5m &&
revdep-rebuild

# emerge --config =dev-db/mariadb-10.5.9-r3

eselect news list &&
sleep 1m &&
eselect news read &&
sleep 1m &&
eselect news purge

rc-update add metalog default &&
rc-update add bluetooth default &&
rc-update add cupsd default &&
rc-update add dbus default &&
rc-update add elogind boot &&
rc-update add display-manager default &&
rc-update add lvm boot &&
rc-update add NetworkManager default

useradd -m -G users,wheel,audio,cdrom,portage,usb,video,lp,lpadmin,uucp,plugdev -s /bin/bash mod

passwd mod

passwd

history -c && sync

exit

cd

umount -l /mnt/gentoo/dev{/shm,/pts,}

umount -R /mnt/gentoo

exit

exit

exit
