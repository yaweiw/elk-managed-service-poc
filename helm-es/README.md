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
yaweis-MBP:elk-managed-service-poc yaweiwang$ helm install helm-es/
NAME:   telling-seastar
LAST DEPLOYED: Tue Jun  6 15:12:32 2017
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/Service
NAME                     CLUSTER-IP    EXTERNAL-IP  PORT(S)                        AGE
elasticsearch-discovery  10.0.237.109  <none>       9300/TCP                       2s
elasticsearch            10.0.163.57   <pending>    9200:30173/TCP,9300:30885/TCP  2s
elasticsearch-data       None          <none>       9300/TCP                       2s

==> v1beta1/Deployment
NAME                  DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
elasticsearch-master  3        3        3           0          2s
elasticsearch-client  2        2        2           0          2s

==> v1beta1/StatefulSet
NAME                DESIRED  CURRENT  AGE
elasticsearch-data  3        1        2s

==> v1beta1/StorageClass
NAME  TYPE
fast  kubernetes.io/azure-disk  
slow  kubernetes.io/azure-disk  

## Verify the installation
* kubectl proxy to launch k8s dashboard
* kubectl get svc
* kubectl get pvc
* Azure portal

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
* statefulset is a beta feature.
* Storage account is required to have 'vhds' container in it as a prerequesite. https://github.com/kubernetes/kubernetes/issues/38362. 