#!/usr/bin/env bash


ssh ubuntu@pileus "curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC='--flannel-backend=none --disable-network-policy --write-kubeconfig-mode 644 --tls-san $1' sh -"

ssh ubuntu@pileus "mkdir -p ~/.kube"
ssh ubuntu@pileus "cp /etc/rancher/k3s/k3s.yaml ~/.kube/config"
scp ubuntu@pileus:/home/ubuntu/.kube/config ./config
sed -i.bak "s/127.0.0.1/$1/" ./config
rm -f config.bak