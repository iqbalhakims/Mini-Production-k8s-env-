#!/bin/bash
set -eux

apt-get update -y
apt-get install -y apt-transport-https ca-certificates curl

# Disable swap
swapoff -a
sed -i '/ swap / s/^/#/' /etc/fstab

# Containerd
apt-get install -y containerd
mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml
systemctl restart containerd
systemctl enable containerd

# Kubernetes repo
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key \
 | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' \
| tee /etc/apt/sources.list.d/kubernetes.list

apt-get update -y
apt-get install -y kubelet kubeadm kubectl

systemctl enable kubelet
