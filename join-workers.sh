#!/usr/bin/env bash

KUBEADM_JOIN=`vagrant ssh master -- sudo kubeadm token create --print-join-command --ttl 0`
vagrant ssh worker1 -- "sudo $KUBEADM_JOIN" 

