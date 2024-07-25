#!/usr/bin/env bash

ssh ubuntu@pileus "sudo su - <<EOF
ip link delete cilium_host
ip link delete cilium_net
ip link delete cilium_vxlan
iptables-save | grep -iv cilium | iptables-restore
ip6tables-save | grep -iv cilium | ip6tables-restore
EOF"

ssh ubuntu@pileus "/usr/local/bin/k3s-uninstall.sh"
