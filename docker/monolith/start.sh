#!/bin/bash
#
# Perform init for ELK server.
# start.sh
sudo service elasticsearch restart
sudo service kibana restart
sudo service nginx restart
sudo service logstash restart

# Load Kibana Dashboard
apt-get -y install curl
cd ~
curl -L -O https://download.elastic.co/beats/dashboards/beats-dashboards-1.1.0.zip 
apt-get -y install unzip 
unzip beats-dashboards-*.zip 
cd beats-dashboards-* 
./load.sh 

# Load Filebeat index template
cd ~ 
curl -O https://gist.githubusercontent.com/thisismitch/3429023e8438cc25b86c/raw/d8c479e2a1adcea8b1fe86570e42abab0f10f364/filebeat-index-template.json
curl -XPUT 'http://localhost:9200/_template/filebeat?pretty' -d@filebeat-index-template.json
