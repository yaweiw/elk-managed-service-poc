# Kibana based on Kubernetes 

## Prerequisite
1. Have an elasticsearch server endpoint at [http://elasticsearch:9200]
2. Since the creation of load balancer, Minikube is no longer supported. Please configure ACS in Kubernetes.


## Instructions:
1. Build a docker image, such as  ```docker build -t zhiyuan.azurecr.io/kibana:1.0.0```
2. Push the image to a docker registry. ```docker push zhiyuan.azurecr.io/kibana:1.0.0``` [Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-docker-cli)
3. Specify the image URL in kibana.yaml. If the registry is private, configuration of secret is required. [Kubernetes doc about private registry](https://kubernetes.io/docs/concepts/containers/images/#using-azure-container-registry-acr)
4. Run the service: ```kubectl create -f kibana-svc.yaml```
5. Run the container: ```kubectl create -f kibana.yaml```