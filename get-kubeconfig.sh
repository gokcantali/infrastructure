#!/usr/bin/env bash

scp ubuntu@bachelor:/home/ubuntu/.kube/config ./config
sed -i "s/127.0.0.1/160.85.252.183/" config
