## Get started
* git clone https://github.com/kubernetes/helm
* helm init
Note: This will install Tiller into the Kubernetes cluster you saw with kubectl config current-context.
* helm install docs/examples/nginx
* kubectl get deployment
* kubectl get svc
Note: if external IP is none, run kubectl delete svc and kubectl expose deployments <deployment> --port=80 --type=LoadBalancer to expose a external endpoint.
* Run helm install --dry-run --debug docs/examples/nginx to see how final render of this chart looks like.

## Install ELK using helm
* helm install helm-es
yaweis-MBP:elk-managed-service-poc yaweiwang$ helm install helm-elk/
helm install helm-elk/
NAME:   deadly-olm
LAST DEPLOYED: Wed Jun  7 11:46:47 2017
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1beta1/Deployment
NAME                  DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
kibana                1        1        1           0          1s
elasticsearch-client  2        2        2           0          1s
elasticsearch-master  3        3        3           0          1s

==> v1beta1/StatefulSet
NAME                DESIRED  CURRENT  AGE
elasticsearch-data  3        1        1s

==> v1beta1/StorageClass
NAME  TYPE
fast  kubernetes.io/azure-disk  
slow  kubernetes.io/azure-disk  

==> v1/Service
NAME                     CLUSTER-IP    EXTERNAL-IP  PORT(S)                        AGE
elasticsearch            10.0.4.237    <pending>    9200:30763/TCP,9300:30650/TCP  2s
kibana                   10.0.242.196  <pending>    5601:31324/TCP                 2s
elasticsearch-discovery  10.0.184.221  <none>       9300/TCP                       1s
elasticsearch-data       None          <none>       9300/TCP                       1s

## Verify the installation
* kubectl proxy. Launch k8s portal and verify the deployment status.
* To verify connectivity between Kibana and Elasticsearch:
1. kubectl get pod
2. kubectl exec <pod name of kibana> curl http://elasticsearch:9200
* To verify statefulset status:
1. kubectl get pvc
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
* ki-svc.yaml - kibana service in k8s
* ki.yaml - kibana deployment definition

## Important Notes:
* statefulset is a beta feature.
* Storage account is required to have 'vhds' container in it as a prerequesite. https://github.com/kubernetes/kubernetes/issues/38362. 