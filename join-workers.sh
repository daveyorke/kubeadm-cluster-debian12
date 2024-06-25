#!/usr/bin/env bash

# if [ $# -eq 0 ]
#   then
#     echo "No arguments supplied. Supply the name(s) of each worker node."
#     echo
#     echo "Example: ./join-workers.sh worker1     "
#     echo "                    -or-               "
#     echo "         ./join-workers.sh worker{1..4}"
#     echo
#     echo "Exiting."
#     exit 1
# fi

# Pass number of worker nodes to this script
WORKERS=`vagrant status | grep "worker" | awk '{print $1}'`
# WORKERS=$@
# NUMWORKERS=$(($1))

# Obtain join script from master node
echo "Obtaining join script from master node..."
KUBEADM_JOIN=`vagrant ssh master -- sudo kubeadm token create --print-join-command --ttl 0`
echo "Join command obtained."
echo

for worker in $WORKERS
do 
  echo "Adding $worker ..."
  vagrant ssh $worker -- sudo $KUBEADM_JOIN 
  echo "Added $worker."
  echo
done

echo "It may take a few minutes for all workers to be ready."
vagrant ssh master -- sudo kubectl get nodes



