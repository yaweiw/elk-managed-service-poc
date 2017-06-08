#!/bin/bash
#
# Create image pull secret.

export PATH=/usr/local/bin/:$PATH

#######################################
# Create image pull secret
# Arguments:
#   None
# Returns:
#   None
#######################################
createips() {
  DOCKER_REGISTRY_SERVER=$1 #elkacr.azurecr.io
  DOCKER_USER=$2 #elkacr
  DOCKER_PASSWORD=$3 #6ihy/+YLCbByT/ut1F2X9DRSplgm8HHC
  DOCKER_EMAIL=$4 #yaweiw@microsoft.com
  SECRET_NAME=$5
  kubectl delete secret $SECRET_NAME #azure-registry
  kubectl create secret docker-registry $SECRET_NAME \
                     --docker-server=$DOCKER_REGISTRY_SERVER \
                     --docker-username=$DOCKER_USER \
                     --docker-password=$DOCKER_PASSWORD \
                     --docker-email=$DOCKER_EMAIL
}

createips elkacr.azurecr.io \
          elkacr \
          6ihy/+YLCbByT/ut1F2X9DRSplgm8HHC \
          yaweiw@microsoft.com \
          azure-registry