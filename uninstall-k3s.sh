#!/usr/bin/env bash

ssh ubuntu@pileus "sudo ip link delete cilium_host"
ssh ubuntu@pileus "sudo ip link delete cilium_net"
ssh ubuntu@pileus "sudo ip link delete cilium_vxlan"
ssh ubuntu@pileus "sudo iptables-save | grep -iv cilium | iptables-restore"
ssh ubuntu@pileus "sudo ip6tables-save | grep -iv cilium | ip6tables-restore"

ssh ubuntu@pileus "/usr/local/bin/k3s-uninstall.sh"
