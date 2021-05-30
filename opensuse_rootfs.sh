#!/bin/bash
# SPDX-License-Identifier: CC0-1.0
# Copyright (C) 2021 Intel Corporation. All rights reserved.

mkdir -p "$1/etc/zypp/"
zypp_conf=/etc/zypp/zypp.conf
[ -f "$zypp_conf" ] && cp -L "$zypp_conf" "$1/$zypp_conf" && cp -r /etc/zypp/repos.d $1/etc/zypp
