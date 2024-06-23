#!/usr/bin/env bash

### init k8s
KUBE_VERSION=1.29.2

rm /root/.kube/config || true
kubeadm init --kubernetes-version=${KUBE_VERSION} --ignore-preflight-errors=NumCPU --skip-token-print --pod-network-cidr 192.168.0.0/16 --apiserver-advertise-address 192.168.25.10 

mkdir -p ~/.kube
sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config

### CNI
kubectl apply -f https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/calico.yaml


# etcdctl
ETCDCTL_VERSION=v3.5.1
ETCDCTL_ARCH=$(dpkg --print-architecture)
ETCDCTL_VERSION_FULL=etcd-${ETCDCTL_VERSION}-linux-${ETCDCTL_ARCH}
wget https://github.com/etcd-io/etcd/releases/download/${ETCDCTL_VERSION}/${ETCDCTL_VERSION_FULL}.tar.gz
tar xzf ${ETCDCTL_VERSION_FULL}.tar.gz ${ETCDCTL_VERSION_FULL}/etcdctl
mv ${ETCDCTL_VERSION_FULL}/etcdctl /usr/bin/
rm -rf ${ETCDCTL_VERSION_FULL} ${ETCDCTL_VERSION_FULL}.tar.gz

# echo
# echo "### COMMAND TO ADD A WORKER NODE ###"
# kubeadm token create --print-join-command --ttl 0
