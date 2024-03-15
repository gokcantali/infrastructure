#!/usr/bin/env bash


ssh ubuntu@bachelor "curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC='--flannel-backend=none --disable-network-policy --write-kubeconfig-mode 644 --tls-san 160.85.252.183' sh -"

ssh ubuntu@bachelor "sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config"
scp ubuntu@bachelor:/home/ubuntu/.kube/config ./config
sed -i "s/127.0.0.1/160.85.252.183/" config
