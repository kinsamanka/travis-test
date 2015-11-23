#!/bin/sh
cd /usr/src/machinekit
./debian/configure -prx
debuild -eDEB_BUILD_OPTIONS="parallel=2" -us -uc -b -j2
