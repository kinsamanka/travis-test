#!/bin/sh

PROOT_OPTS="-b /dev/shm -r ${ROOT}"
if echo $PROOT_OPTS | grep -iq arm; then
	PROOT_OPTS+="-q qemu-arm-static"
fi

# copy source
mkdir -p ${ROOT}/usr/src/build/${MK_DIR}
cp -a ${ROOT}/usr/src/machinekit ${ROOT}/usr/src/build/${MK_DIR}

# rip build
proot ${PROOT_OPTS} /usr/src/build_rip.sh

# disable avahi
echo "ANNOUNCE_IPV4=0\nANNOUNCE_IPV6=0" >> \
	${ROOT}/usr/src/build/${MK_DIR}/machinekit/etc/linuxcnc/machinekit.ini

# runtests needs full access, must use chroot
mount -o bind /proc /opt/rootfs/proc
mount -o bind /dev /opt/rootfs/dev
mount -o bind /dev/shm /opt/rootfs/dev/shm
mount -o bind /dev/pts /opt/rootfs/dev/pts

chroot --userspec=mk:mk ${ROOT} /usr/src/runtests.sh 
