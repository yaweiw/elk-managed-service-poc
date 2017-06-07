# Use AZ to create kubernetes cluster in Azure
## Create
* RESOURCE_GROUP=elk-rg
* LOCATION=westus
* az group create --name=$RESOURCE_GROUP --location=$LOCATION
* DNS_PREFIX=elk-kube-acs
* CLUSTER_NAME=elk-kube-acs-cluster
* az acs create --orchestrator-type=kubernetes --resource-group $RESOURCE_GROUP --name=$CLUSTER_NAME --dns-prefix=$DNS_PREFIX --generate-ssh-keys
## Connect
* az acs kubernetes install-cli (if kubectl not installed yet)
* az acs kubernetes get-credentials --resource-group=$RESOURCE_GROUP --name=$CLUSTER_NAME
* kubectl get nodes

## Verify
* kubectl run nginx --image nginx
* kubectl get pods

## Expose the service to the world
* kubectl expose deployments nginx --port=80 --type=LoadBalancer
* kubectl get svc - monitor the service from pending to ready

## Browse the K8s UI
* kubectl proxy
* http://localhost:8001/ui

## Remote sessions to containers
* kubectl get pods
* kubectl exec <pod name> <command>
