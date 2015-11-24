#!/bin/sh
# copy source
mkdir -p /opt/rootfs/usr/src/build/${MK_DIR}
cp -a /opt/rootfs/usr/src/machinekit /opt/rootfs/usr/src/build/${MK_DIR}

# rip build
proot -b /dev/shm -r /opt/rootfs /usr/src/build_rip.sh

# disable avahi
echo "ANNOUNCE_IPV4=0\nANNOUNCE_IPV6=0" >> \
	/opt/rootfs/usr/src/build/${MK_DIR}/machinekit/etc/linuxcnc/machinekit.ini

# runtests needs full access, must use chroot
mount -o bind /proc /opt/rootfs/proc
mount -o bind /dev /opt/rootfs/dev
mount -o bind /dev/shm /opt/rootfs/dev/shm
mount -o bind /dev/pts /opt/rootfs/dev/pts

chroot --userspec=mk:mk /opt/rootfs /usr/src/runtests.sh 
