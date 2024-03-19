#!/usr/bin/env bash

NODE_IPS=(10.0.2.201)

for NODE_IP in "${NODE_IPS[@]}"; do
    TOKEN=$(ssh ubuntu@bachelor "sudo cat /var/lib/rancher/k3s/server/node-token")
    ssh ubuntu@bachelor "ssh ubuntu@${NODE_IP} \"curl -sfL https://get.k3s.io | K3S_URL=https://10.0.0.209:6443 K3S_TOKEN='${TOKEN}' sh -\""
done
