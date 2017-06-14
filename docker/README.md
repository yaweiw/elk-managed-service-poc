# Use AZ to create kubernetes cluster in Azure
## Create
* RESOURCE_GROUP=elk-rg
* LOCATION=westus
* az group create --name=$RESOURCE_GROUP --location=$LOCATION
* DNS_PREFIX=elk-kube-acs
* CLUSTER_NAME=elk-kube-acs-cluster
* az acs create --orchestrator-type=kubernetes --resource-group $RESOURCE_GROUP --name=$CLUSTER_NAME --dns-prefix=$DNS_PREFIX --generate-ssh-keys
Note: it's also required to create a storage account e.g. azdisksa (with vhds container) for storage class and provision a ACR e.g. elkacr for docker image storage.
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
## Instructions:
1. Create a container registry in ACR e.g. ```elkimages.azurecr.io```
2. Access keys blade. Get your Username and password for authentication to ACR
3. Run ```docker login <registry_name>.azurecr.io``` and input username and password
4. Go to respective directories and run e.g. ```docker build -t <registry_name>.azurecr.io/kibana:1.0.0 .``` to build docker image
5. Run ```docker push <registry_name>.azurecr.io/kibana:1.0.0``` to push image to [Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-docker-cli)

## Shell script:
1. Just replace the registry url, username, passwork in push_images.sh.
2. Launch it.

## Exist ACR for use:
1. URL: ```elkimages.azurecr.io```
2. username: ```elkimages```
3. password: ```fZf=wtlP7E4JfjUNyrllZa4BHkKlxSii```
4. password2: ```P7puImBV+Aq7EwwSP/WR93PahU84XmqQ```
