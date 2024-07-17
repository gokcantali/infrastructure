#!/usr/bin/env bash

NODE_IPS=($2)

for NODE_IP in "${NODE_IPS[@]}"; do
    TOKEN=$(ssh ubuntu@pileus "sudo cat /var/lib/rancher/k3s/server/node-token")
    ssh ubuntu@pileus "ssh ubuntu@${NODE_IP} \"curl -sfL https://get.k3s.io | K3S_URL=https://$1:6443 K3S_TOKEN='${TOKEN}' sh -\""
done
