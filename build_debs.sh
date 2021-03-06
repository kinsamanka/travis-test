#!/bin/sh -ex

# build unsinged packages
DEBUILD_OPTS="-eDEB_BUILD_OPTIONS="parallel=${JOBS}" -us -uc -j${JOBS}"

# build source debs only on amd64
if !(echo ${TAG} | grep -q 64); then
	DEBUILD_OPTS="${DEBUILD_OPTS} -b"
fi

# copy source
cp -a /usr/src/machinekit /usr/src/build/${MK_DIR}

# build debs
cd /usr/src/build/${MK_DIR}/machinekit

# create upstream tarball for source debs
if (echo ${TAG} | grep -q 64); then
	git archive --format tgz -o ../machinekit_0.1.1.orig.tar.gz master
fi

./debian/configure ${FLAV_OPTS}
debuild ${DEBUILD_OPTS}

# cleanup
rm -rf /usr/src/build/${MK_DIR}/machinekit
