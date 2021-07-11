#!/bin/bash
# SPDX-License-Identifier: CC0-1.0
# Copyright (C) 2021 Intel Corporation. All rights reserved.

mkdir -p "$1/etc/dnf/"
dnf_conf=/etc/dnf/dnf.conf
[ -f "$dnf_conf" ] && cp -L "$dnf_conf" "$1/$dnf_conf"

printf "#!/bin/bash\\n\\nmkdir -p /root/host_share\\nmount -t 9p -o trans=virtio host_share /root/host_share -oversion=9p2000.L,posixacl,msize=104857600,cache=loose\\n" > "$1/root/mount_9p.sh"
chmod +x "$1/root/mount_9p.sh"
