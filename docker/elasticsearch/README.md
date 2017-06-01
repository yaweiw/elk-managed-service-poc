# Build
* docker build -t es-img:1.0.0 .
* Note: es host (default 0.0.0.0) listens on any IPV4 addresses. es port (default 9200) for REST.
* Run docker run --rm -dit -p 9200:9200 <image id>
* To verify if ES is setup properly:
    * docker ps
    * docker exec <container id> curl localhost:9200
    * curl localhost:9200