#!/bin/bash

echo "starting cxl (check cxl.txt for log)"
nohup ./run_qemu.sh --vp-workspace `pwd`/.. --preset 2S0 --cxl --cxl-debug --cxl-hb --debug --rdma --kcmd-append=`pwd`/extra_kcmd --rebuild=none --instance 2 `pwd`/../linux &> cxl.txt &
