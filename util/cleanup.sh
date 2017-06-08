#!/bin/bash
#
# Perform clean up work.

export PATH=/usr/local/bin/:$PATH

#######################################
# Cleanup provisoned ELK resources
# Arguments:
#   None
# Returns:
#   None
#######################################
cleanup() {
  kubectl delete storageclass slow
  kubectl delete storageclass fast

  kubectl delete deployment -l component=kibana
  kubectl delete deployment -l component=elasticsearch

  kubectl delete replicaset -l component=kibana
  kubectl delete replicaset -l component=elasticsearch
  
  kubectl delete svc -l component=kibana
  kubectl delete svc -l component=elasticsearch
  
  kubectl delete statefulsets -l component=elasticsearch;role=data
  kubectl delete svc -l component=elasticsearch;role=data
  kubectl delete pvc -l component=elasticsearch;role=data
  kubectl delete pod -l component=elasticsearch;role=data
  kubectl delete pv --all
}

cleanup

