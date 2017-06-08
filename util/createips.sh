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
  DOCKER_REGISTRY_SERVER=$1
  DOCKER_USER=$2
  DOCKER_PASSWORD=$3
  DOCKER_EMAIL=$4
  SECRET_NAME=$5
  kubectl delete secret $SECRET_NAME
  kubectl create secret docker-registry $SECRET_NAME \
                     --docker-server=$DOCKER_REGISTRY_SERVER \
                     --docker-username=$DOCKER_USER \
                     --docker-password=$DOCKER_PASSWORD \
                     --docker-email=$DOCKER_EMAIL
}

createips elkacr.azurecr.io \
          elkacr \
          <password> \
          <email> \
          azure-registry