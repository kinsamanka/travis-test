#!/bin/sh
cd /usr/src/machinekit/src
./autogen.sh
./configure \
	CC=arm-linux-gnueabihf-gcc \
	CXX=arm-linux-gnueabihf-g++ \
	--with-posix \
	--without-rt-preempt \
	--without-xenomai \
	--without-xenomai-kernel \
	--without-rtai-kernel
make -j4
