#!/usr/bin/env bash

scp ubuntu@bachelor:/home/ubuntu/.kube/config ./config
sed -i "s/127.0.0.1/$1/" config
