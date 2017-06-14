## Get started
* ```git clone https://github.com/kubernetes/helm```
* ```helm init``` 

    Note: This will install Tiller into the Kubernetes cluster you saw with kubectl config current-context.
* ```helm install docs/examples/nginx```
* ```kubectl get deployment```
* ```kubectl get svc```

    Note: if external IP is none, run ```kubectl delete svc``` and ```kubectl expose deployments <deployment> --port=80 --type=LoadBalancer``` to expose a external endpoint.
* Run ```helm install --dry-run --debug docs/examples/nginx``` to see how final render of this chart looks like.

## Install ELK using helm


## Verify the installation
* ```kubectl proxy```. Launch k8s portal and verify the deployment status.
* To verify Elasticsearch cluster:
1. ```kubectl exec <anynode> curl http://elasticsearch:9200/_cat/nodes?v```
* To verify connectivity between Kibana and Elasticsearch:
1. ```kubectl get pod```
2. ```kubectl exec <pod name of kibana> curl http://elasticsearch:9200```
* To verify statefulset status:
1. ```kubectl get pvc```
2. Go to Azure portal check storage acocunt.

## What's in templates folder
* _helpers.tpl - dependent chart template helpers
* azure-storageclass-hdd.yaml - azure storageclass using hdd
* azure-storageclass-ssd.yaml - azure storageclass using ssd
* es-client.yaml - client node, intended for client usage, no data, with HTTP API
* es-data-stateful.yaml - stateful set for elasticsearch data storage
* es-data-svc.yaml - data node, intended for storing and indexing data, no HTTP API
* es-discovery-svc.yaml - discovery service
* es-master.yaml - master node, intended for clustering management only, no data, no HTTP API
* es-svc.yaml - elasticsearch service in k8s

## Important Notes:
* StatefulSet is a beta feature.
* Storage account is required to have 'vhds' container in it as a prerequesite. https://github.com/kubernetes/kubernetes/issues/38362. 
* Create imagepullsecret named "azure-registry"
```DOCKER_REGISTRY_SERVER=elkacr.azurecr.io```
```DOCKER_USER=elkacr```
```DOCERK_PASSWORD=+op+=6//=F/=/+=JkpA0i=/=WTeTdOYB```
```DOCKER_EMAIL=yaweiw@microsoft.com```
```kubectl create secret docker-registry azure-registry --docker-server=DOCKER_REGISTRY_SERVER --docker-username=DOCKER_USER --docker-password=DOCKER_PASSWORD --docker-email=DOCKER_EMAIL```