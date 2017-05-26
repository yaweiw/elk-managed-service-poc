## elk-managed-service-poc
Poc project for ELK managed service on Azure
## docker/monolith
* contains dockerfile and configs to setup a single node ELK cluster
* Go to docker/monolith and run:
    * docker build .
    * docker run --rm -it -p 80:80 -p 5044:5044 <image_id>
    * access to http://hostname or ip on the same server or from different ones
    * follow this link: https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-installation.html to install filebeat for log shipping on your client machine.
    * E.g. on mac do the following:
        * curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.4.0-darwin-x86_64.tar.gz
        * tar xzvf filebeat-5.4.0-darwin-x86_64.tar.gz
        * modify filebeat.yml:
            * paths e.g. /Users/XXX/*.log
            * output.logstash e.g. hosts: ["localhost:5044"]
            * ssl.certificate_authorities
            * ssl.certificate
            * ssl.key



