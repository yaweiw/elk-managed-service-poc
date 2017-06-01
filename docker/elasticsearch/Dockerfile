#Download base image ubuntu 14.04
FROM ubuntu:14.04

# Update Ubuntu Software repository
RUN apt-get update

# Install Java 8
RUN apt-get -y install software-properties-common python-software-properties
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get -y install oracle-java8-installer

# Install Elasticsearch
RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
RUN echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
RUN apt-get update
RUN apt-get -y install elasticsearch
COPY elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

# test
RUN apt-get -y install curl

# start.sh
COPY start.sh /usr/local/sbin/start.sh 
RUN chmod +x /usr/local/sbin/start.sh
CMD /usr/local/sbin/start.sh && tail -f /dev/null

EXPOSE 9200


