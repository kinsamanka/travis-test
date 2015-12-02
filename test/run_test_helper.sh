#!/bin/sh -ex

. /usr/src/machinekit/scripts/rip-environment

# run regression tests
for i in `seq 1 100`; do 
    runtests
done
