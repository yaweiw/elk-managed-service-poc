helm init

# create namespace
namespace=elk-cluster-ns

helm install --set common.namespace=${namespace} ns

# create secret
registry-name=azure-registry
registry-server=elkimages.azurecr.io
registry-username=elkimages
registry-password=fZf=wtlP7E4JfjUNyrllZa4BHkKlxSii
registry-email=t-zhzhe@microsoft.com

kubectl create secret docker-registry ${registry-name} \
--docker-server=${registry-server} \
--docker-username=${registry-username} \
--docker-password=${registry-password} \
--docker-email=${registry-email}

# create Elastcisearch
helm install --set common.namespace=${namespace}\
--set image.repository=${registry-server}/es\
--set imagePullSecrets.name=${registry-name} es

# create Kibana
helm install --set common.namespace=${namespace}\
--set image.repository=${registry-server}/kibana\
--set imagePullSecrets.name=${registry-name}\
--set replicaCount=3 kibana

# create Logstash
helm install --set common.namespace=${namespace}\
--set image.repository=${registry-server}/logstash\
--set imagePullSecrets.name=${registry-name}\
--set replicaCount=3 logstash