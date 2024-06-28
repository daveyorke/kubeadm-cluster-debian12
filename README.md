# kubeadm-cluster-debian12

This is a repository created thanks to the great work done by Kim Wuestcamp for his CKS Course Environment on Killer.sh.  I took his cluster setup scripts and modified them for use on a Debian 12 installation with Vagrant and Libvirt. His instructions depended upon creating VMs in Google Cloud Platform (GCP) and executing installation scripts, which were only compatible with Ubuntu 20.04. 

### Prerequisites
- Debian 12 (Bookworm)
- vagrant
- libvirt
- git

### Kubernetes Environment
- kubeadm deployment (version 1.29.2)
- podman
- containerd
- calico networking

### Features
- Single master node and user-definable count of worker nodes
- User-definable CPU and memory for all nodes
- Post installation script to join the workers to the cluster (must run manually for the time being)

### Instructions
1. Clone this repository into a folder

```bash
git clone https://github.com/daveyorke/kubeadm-cluster-debian12.git
cd kubeadm-cluster-debian12
```

2. Modify the Vagrantfile for your specific lab needs
```bash
# Number of Worker Nodes
WORKER_COUNT        = 2

# Master Node Configuration
CPUS_MASTER_NODE    = 4
MEMORY_MASTER_NODE  = 4096

# Worker Node Configuration
CPUS_WORKER_NODE    = 2
MEMORY_WORKER_NODE  = 2048

```

3. Bring up the environment
```bash
vagrant up
```

4. Join the worker nodes
```bash
./join-workers.sh
```

5. SSH into the master and have fun!
```bash
# Connect to master
vagrant ssh master

# Must be root to execute kubectl commands
sudo -i

# Example kubectl command
kubectl get nodes

# Example output from previous command:
NAME      STATUS   ROLES           AGE   VERSION
master    Ready    control-plane   79s   v1.29.2
worker1   Ready    <none>          42s   v1.29.2
worker2   Ready    <none>          38s   v1.29.2

```
