#!/bin/bash
#
# Perform set up work for K8s cluster in ACS

export PATH=/usr/local/bin/:$PATH

#######################################
# Setup Kubernetes cluster in ACS
# Arguments:
#   RESOURCE_GROUP
#   LOCATION
#   CLUSTER_NAME
#   DNS_PREFIX
# Returns:
#   None
#######################################
setup() {
  RESOURCE_GROUP=$1
  LOCATION=$2
  CLUSTER_NAME=$3
  DNS_PREFIX=$4
  az group create --name=$RESOURCE_GROUP \
                  --location=$LOCATION
  az acs create --orchestrator-type=kubernetes \
                --resource-group $RESOURCE_GROUP \
                --name=$CLUSTER_NAME \
                --dns-prefix=$DNS_PREFIX \
                --generate-ssh-keys
  az acs kubernetes get-credentials \
                --resource-group=$RESOURCE_GROUP \
                --name=$CLUSTER_NAME
}

setup elk-rg \
      westus \
      elk-kube-acs \
      elk-kube-acs-cluster
kubectl get nodes