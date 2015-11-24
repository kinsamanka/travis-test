#!/bin/sh -ex

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
chown -R mk:mk ../

make setuid

