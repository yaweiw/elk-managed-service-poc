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

# Build your own ELK images and push to ACR
## Kibana
* Dependency: Elasticsearch endpoint [http://elasticsearch:9200]

## Instructions:
1. Create a container registry in ACR e.g. ```elkacr.azurecr.io```
2. Access keys blade. Get your Username and password for authentication to ACR
1. Run ```docker build -t elkacr.azurecr.io/kibana:1.0.0 .``` to build docker image
2. Run ```docker push elkacr.azurecr.io/kibana:1.0.0``` to push image to [Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-docker-cli)
3. Specify the image URL in ki.yaml in helm-elk. If the registry is private, configuration of secret is required. [Kubernetes doc about private registry](https://kubernetes.io/docs/concepts/containers/images/#using-azure-container-registry-acr)

## Elasticsearch


## Logstash