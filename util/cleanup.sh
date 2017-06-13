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
  
  kubectl delete storageclass slow --namespace elk-cluster-ns
  kubectl delete storageclass fast --namespace elk-cluster-ns

  kubectl delete deployment -l component=kibana --namespace elk-cluster-ns
  kubectl delete deployment -l component=elasticsearch --namespace elk-cluster-ns
  kubectl delete deployment -l component=logstash --namespace elk-cluster-ns

  kubectl delete replicaset -l component=kibana --namespace elk-cluster-ns
  kubectl delete replicaset -l component=elasticsearch --namespace elk-cluster-ns
  kubectl delete replicaset -l component=logstash --namespace elk-cluster-ns

  kubectl delete daemonset -l component=filebeat --namespace elk-cluster-ns
  
  kubectl delete svc -l component=kibana --namespace elk-cluster-ns
  kubectl delete svc -l component=elasticsearch --namespace elk-cluster-ns
  kubectl delete svc -l component=logstash --namespace elk-cluster-ns
  
  kubectl delete statefulsets --namespace elk-cluster-ns -l component=elasticsearch;role=data
  kubectl delete svc --namespace elk-cluster-ns -l component=elasticsearch;role=data
  kubectl delete pvc --namespace elk-cluster-ns -l component=elasticsearch;role=data 
  kubectl delete pod --namespace elk-cluster-ns -l component=elasticsearch;role=data
  kubectl delete pv --all --namespace elk-cluster-ns

  kubectl delete namespace elk-cluster-ns
}

cleanup

