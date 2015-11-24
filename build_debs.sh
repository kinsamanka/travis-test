#!/bin/sh -ex

proot -b /dev/shm -r /opt/rootfs \
	sh -exc 'cd /usr/src/machinekit.1; \
		 ./debian/configure -prx; \
		 debuild -eDEB_BUILD_OPTIONS="parallel=2" -us -uc -b -j2'

		  