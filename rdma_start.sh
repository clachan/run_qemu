#!/bin/bash

echo "starting rdma_host (check rdma_host.txt for log)"
nohup ./run_qemu.sh --vp-workspace `pwd`/.. --preset 2S0 --cxl --cxl-debug --debug --rdma --kcmd-append=`pwd`/extra_kcmd --rebuild=none --instance 0 `pwd`/../linux &> rdma_host.txt &
echo "starting rdma_target (check rdma_host.txt for log)"
nohup ./run_qemu.sh --vp-workspace `pwd`/.. --preset 2S0 --cxl --cxl-debug --debug --rdma --kcmd-append=`pwd`/extra_kcmd --rebuild=none --instance 1 `pwd`/../linux &> rdma_target.txt &

((count = 20))
while [[ $count -ne 0 ]] ; do
    echo "trying to connect to rdma_host"
    ssh -p 10022 -o "StrictHostKeyChecking no" root@localhost exit
    rc=$?
    if [[ $rc -eq 0 ]] ; then
	echo "rdma_host connected: setting up RDMA NIC and rename hostname"
	ssh -p 10022 -o "StrictHostKeyChecking no" root@localhost "modprobe rdma_rxe; rdma link add rxe_eth1 type rxe netdev eth1; nmcli device modify eth1 ipv4.method manual ipv4.addr 192.168.0.101/24; hostname rdma-host"
	break
    fi
    ((count = count - 1))
    sleep 1s
done

((count = 20))
while [[ $count -ne 0 ]] ; do
    echo "trying to connect to rdma_target"
    ssh -p 10023 -o "StrictHostKeyChecking no" root@localhost exit
    rc=$?
    if [[ $rc -eq 0 ]] ; then
	echo "rdma_target connected: setting up RDMA NIC and rename hostname"
	ssh -p 10023 -o "StrictHostKeyChecking no" root@localhost "modprobe rdma_rxe; rdma link add rxe_eth1 type rxe netdev eth1; nmcli device modify eth1 ipv4.method manual ipv4.addr 192.168.0.102/24; hostname rdma-target"
	break
    fi
    ((count = count - 1))
    sleep 1s
done
