#!/usr/bin/env bash

scp ubuntu@pileus:/home/ubuntu/.kube/config ./config
sed -i.bak "s/127.0.0.1/$1/" ./config
rm -f config.bak
