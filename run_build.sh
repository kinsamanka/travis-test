#!/bin/sh -ex

PROOT_OPTS="-b /dev/shm -r ${ROOT}"
if echo ${TAG} | grep -iq arm; then
	PROOT_OPTS="${PROOT_OPTS} -q qemu-arm-static"
fi

case "${FLAV}" in
   "posix") FLAV_OPTS="-p"
   ;;
   "rt_preempt") FLAV_OPTS="-r" 
   ;;
   "xenomai") FLAV_OPTS="-x" 
   ;;
   *) FLAV_OPTS="-prx" 
   ;;
esac

export FLAV_OPTS

mkdir -p ${ROOT}/usr/src/build/${MK_DIR}
proot ${PROOT_OPTS} /usr/src/build_debs.sh | \
	tee ${ROOT}/usr/src/build/${MK_DIR}/output.log

# print out the results
ls -l ${ROOT}/usr/src/build/${MK_DIR}/*deb
