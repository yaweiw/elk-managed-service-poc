registry-server=elkimages.azurecr.io
registry-username=elkimages
registry-password=fZf=wtlP7E4JfjUNyrllZa4BHkKlxSii

docker login --username ${registry-username} --password ${registry-password} ${registry-server}

docker build -t ${registry-server}/es:1.0.0 ./elasticsearch
docker push ${registry-server}/es:1.0.0
docker build -t ${registry-server}/kibana:1.0.0 ./kibana
docker push ${registry-server}/kibana:1.0.0
docker build -t ${registry-server}/logstash:1.0.0 ./logstash
docker push ${registry-server}/logstash:1.0.0
docker build -t ${registry-server}/filebeat:1.0.0 ./filebeat
docker push ${registry-server}/filebeat:1.0.0