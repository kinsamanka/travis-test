#!/bin/sh -ex
cd /usr/src/machinekit/src
useradd mk
chown mk:mk ../ -R
make setuid

echo "ANNOUNCE_IPV4=0\nANNOUNCE_IPV6=0" >> /usr/src/machinekit/etc/linuxcnc/machinekit.ini

cat >../runtests.sh<<EOF
#!/bin/sh -ex
. /usr/src/machinekit/scripts/rip-environment
runtests /usr/src/machinekit/tests
EOF

chmod a+x ../runtests.sh
