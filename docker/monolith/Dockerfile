#Download base image ubuntu 14.04
FROM ubuntu:14.04
ARG KibanaAdmin=kibanaadmin
ARG KibanaAdminPwd=password
ARG ELKServer=ELKServer

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

# Install Kibana
RUN echo "deb http://packages.elastic.co/kibana/4.4/debian stable main" | sudo tee -a /etc/apt/sources.list.d/kibana-4.4.x.list
RUN apt-get update
RUN apt-get -y install kibana
COPY kibana.yml /opt/kibana/config/kibana.yml

# Install Nginx
RUN apt-get -y install nginx apache2-utils
RUN htpasswd -b -c /etc/nginx/htpasswd.users $KibanaAdmin $KibanaAdminPwd
COPY nginxhttp /etc/nginx/sites-available/default
COPY nginxtcp /etc/nginx/sites-available/nginxtcp
RUN nginx -t

# Install Logstash
RUN echo 'deb http://packages.elastic.co/logstash/2.2/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash-2.2.x.list
RUN apt-get update
RUN apt-get -y install logstash
COPY 02-beats-input.conf /etc/logstash/conf.d/02-beats-input.conf
COPY 10-cusomlog-filter.conf /etc/logstash/conf.d/10-cusomlog-filter.conf
COPY 30-elasticsearch-output.conf /etc/logstash/conf.d/30-elasticsearch-output.conf
RUN service logstash configtest

# start.sh
COPY start.sh /usr/local/sbin/start.sh 
RUN chmod +x /usr/local/sbin/start.sh
CMD /usr/local/sbin/start.sh && bash

EXPOSE 80 5044


