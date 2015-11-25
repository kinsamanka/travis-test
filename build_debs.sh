#!/bin/sh -ex

PROOT_OPTS="-b /dev/shm -r ${ROOT}"
if echo ${TAG} | grep -iq arm; then
	PROOT_OPTS="${PROOT_OPTS} -q qemu-arm-static"
fi

case "${FLAVOR}" in
   "posix") option="-p"
   ;;
   "rt_preempt") option="-r" 
   ;;
   "xenomai") option="-x" 
   ;;
   *) option="-prx" 
   ;;
esac

proot ${PROOT_OPTS} -r ${ROOT} \
	sh -exc 'cd /usr/src/; \
		 mkdir -p build/${MK_DIR}; \
		 cp -a machinekit build/${MK_DIR}; \
		 cd build/${MK_DIR}/machinekit; \
		 ./debian/configure ${option}; \
		 debuild -eDEB_BUILD_OPTIONS="parallel=${JOBS}" \
		 	-us -uc -b -j${JOBS}'

# print out the results
ls -l ${ROOT}/usr/src/build/${MK_DIR}/*deb || true