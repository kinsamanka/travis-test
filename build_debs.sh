#!/bin/sh -ex

proot -b /dev/shm -r /opt/rootfs \
	sh -exc 'cd /usr/src/; \
		 mkdir -p build/${MK_DIR}; \
		 cp -a machinekit build/${MK_DIR}; \
		 cd build/${MK_DIR}/machinekit; \
		 ./debian/configure -prx; \
		 debuild -eDEB_BUILD_OPTIONS="parallel=2" -us -uc -b -j2'

ls -l /opt/rootfs/usr/src/build/${MK_DIR}/*deb || true