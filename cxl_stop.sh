#!/bin/bash

ssh -p 10022 -o "StrictHostKeyChecking no" root@localhost shutdown -h now
