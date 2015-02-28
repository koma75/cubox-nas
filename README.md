vagrant-work
============

Ansible playground.

Currently making a vagrant based test bed for Arch Linux file server setup.

## Initial setups

### Install

follow the instructions at ArchLinux ARM http://archlinuxarm.org/platforms/armv7/freescale/cubox-i#qt-platform_tabs-ui-tabs2

### Network+User setups

1. change root password
  * `passwd`
2. setup eth0 for static IP using systemd as shown in [here](https://wiki.archlinux.org/index.php/Network_configuration#Persistent_configuration_on_boot_using_systemd)
  * /etc/conf.d/net-conf-eth0
  * /usr/local/bin/net-up.sh
  * /usr/local/bin/net-down.sh
  * `chmod +x /usr/local/bin/net-{up,down}.sh`
  * /etc/systemd/system/network@.service
  * `systemctl enable network@eth0`
3. `pacman -Sy sudo`
4. `useradd -m -G wheel -s /bin/bash USERNAME`
  * use -u UID option to match your local machine user as needed.
  * dscl . -read /Users/USERNAME UniqueID on MacOS X to see UID
5. `passwd USERNAME`
6. visudo to uncomment the `%wheel ALL=(ALL) ALL` line
7. remote login using ssh rsa key
  * from client machine, `cat ~/.ssh/id_rsa.pub | ssh USERNAME@cubox.local "mkdir -p ~/.ssh && cat >>  ~/.ssh/authorized_keys"`
8. timezone to JST
  * `timedatectl set-timezone Asia/Tokyo`

### Drive setups

1. `pacman -Sy btrfs-progs`
2. find the drive device descriptor using dmesg
3. `mkfs.btrfs -L LABEL /dev/sdX`
4. `mount /dev/sdX /mnt`
5. `btrfs filesystem show /mnt`
  * note the UUID
6. `umount /mnt`
7. edit /etc/fstab
  * `UUID=XXXXXXXX  /mnt/MOUNTDIR   btrfs   noatime,autodefrag,compress-force=lzo,space_cache       0 0`
8. `shutdown -r now` to make sure it mounts automatially

### Prep for Ansible

1. `pacman -Sy ansible`
  * Not absolutely necessary if using remote ansible execution
  * in remote, install python2 `pacman -Sy python2`
2. add ansible user
  * `useradd -m -G wheel -s /bin/bash USERNAME`
  * `passwd USERNAME`
3. add ansible user as nopassword sudoer
  * `ansible ALL=(ALL) NOPASSWD: ALL`
4. remote login using ssh rsa key for ansible
  * `cat ~/.ssh/id_rsa.pub | ssh ansible@cubox.local "mkdir -p ~/.ssh && cat >>  ~/.ssh/authorized_keys"`

## Application setup

run the ansible at https://github.com/koma75/vagrant-work

## Client side

### nfs mounts

#### on MacOS X

* to find what is shared
  * `showmount -e HOST`
* to mount
  * `mount_nfs -P HOST:/path/to/exported /mnt/path`

#### on other *nix

*
