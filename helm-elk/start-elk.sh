#! /bin/bash

# terminate once a command failed
set -e

# create namespace
namespace=elk-cluster-ns

helm install -f config.yaml ns 

# create secret
registry_name=azure-registry
registry_server=elkimages.azurecr.io
registry_username=elkimages
registry_password=fZf=wtlP7E4JfjUNyrllZa4BHkKlxSii
registry_email=t-zhzhe@microsoft.com

kubectl --namespace=${namespace} create secret docker-registry ${registry_name} \
--docker-server=${registry_server} \
--docker-username=${registry_username} \
--docker-password=${registry_password} \
--docker-email=${registry_email}

# create Elasticsearch
helm install -f config.yaml es 

# create Kibana
helm install -f config.yaml kibana

# create Logstash
helm install -f config.yaml logstash
