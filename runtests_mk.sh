#!/bin/sh
cd /usr/src/machinekit/src
./autogen.sh
./configure \
	--with-posix \
	--without-rt-preempt \
	--without-xenomai \
	--without-xenomai-kernel \
	--without-rtai-kernel
make -j2
useradd mk
chown mk:mk ../ -R
make setuid
service dbus start
service avahi-daemon start
cat >run.sh<<EOF
#!/bin/sh -ex
. /usr/src/machinekit/scripts/rip-environment
runtests /usr/src/machinekit/tests
EOF

chmod a+x run.sh
su mk -c /usr/src/machinekit/src/run.sh 
