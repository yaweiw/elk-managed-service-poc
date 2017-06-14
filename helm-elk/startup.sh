#! /bin/bash

# create namespace
namespace=elk-cluster-ns

helm install --set common.namespace=${namespace} ns

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

# create Elastcisearch
data_storageAccount=elks
data_location=southeastasia
helm install --set common.namespace=${namespace} \
--set data.storageAccount=${data_storageAccount} \
--set data.location=${data_location} \
--set image.repository=${registry_server}/es \
--set imagePullSecrets.name=${registry_name} ./es

# create Kibana
helm install --set common.namespace=${namespace} \
--set image.repository=${registry_server}/kibana \
--set imagePullSecrets.name=${registry_name} \
--set replicaCount=3 ./kibana

# create Logstash
helm install --set common.namespace=${namespace} \
--set image.repository=${registry_server}/logstash \
--set imagePullSecrets.name=${registry_name} \
--set replicaCount=3 ./logstash
