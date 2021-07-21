#!/bin/bash

ssh -p 10022 -o "StrictHostKeyChecking no" root@localhost shutdown -h now
ssh -p 10023 -o "StrictHostKeyChecking no" root@localhost shutdown -h now
