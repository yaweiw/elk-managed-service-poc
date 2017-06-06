FROM java:8u111-jre


# Download & Configure kibana
EXPOSE 5601

ENV KIBANA_VERSION 5.4.1
ENV PLATFORM linux-x86_64
ENV DOWNLOAD_URL "https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-${PLATFORM}.tar.gz"
ENV SHA1_URL "https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-${PLATFORM}.tar.gz.sha1"

RUN apk update && apk add openssl

RUN cd /tmp \
  && echo "Install Kibana..." \
  && wget -O kibana.tar.gz "$DOWNLOAD_URL" \
  && tar -xf kibana.tar.gz \
  && mv kibana-$KIBANA_VERSION-$PLATFORM /kibana

# Clear cache
RUN rm -rf /tmp/* /var/cache/apk/*

WORKDIR /kibana
COPY config /kibana/config

ENV KIBANA_PORT 5601
ENV KIBANA_HOST 0.0.0.0
ENV ELASTICSEARCH_URL elasticsearch

CMD /kibana/bin/kibana
