#!/bin/sh -ex
# rip build
proot -b /dev/shm -r /opt/rootfs /usr/src/tmp/build_mk2.sh

# runtests needs full access, must use chroot
mount -o bind /proc /opt/rootfs/proc
mount -o bind /dev /opt/rootfs/dev
mount -o bind /dev/shm /opt/rootfs/dev/shm
mount -o bind /dev/pts /opt/rootfs/dev/pts

chroot --userspec=mk:mk /opt/rootfs /usr/src/machinekit/runtests.sh 
