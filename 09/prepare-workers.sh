#!/bin/bash
set -e

sudo swapoff -a
sudo sed -i.bak '/[[:space:]]swap[[:space:]]/s/^/#/' /etc/fstab

sudo modprobe overlay
sudo modprobe br_netfilter

printf 'overlay\nbr_netfilter\n' | sudo tee /etc/modules-load.d/k8s.conf

printf 'net.bridge.bridge-nf-call-iptables = 1\nnet.bridge.bridge-nf-call-ip6tables = 1\nnet.ipv4.ip_forward = 1\n' | sudo tee /etc/sysctl.d/k8s.conf

sudo sysctl --system > /dev/null

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y containerd apt-transport-https ca-certificates curl gpg

sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml > /dev/null
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl enable --now containerd
sudo systemctl restart containerd

sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y kubelet=1.30.14-1.1 kubeadm=1.30.14-1.1
sudo apt-mark hold kubelet kubeadm

echo "WORKER PREPARATION COMPLETE"
