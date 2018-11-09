FROM ubuntu

RUN apt update && apt install -y curl unzip lighttpd
RUN mkdir -p /opt

#RUN curl --output /opt/xonotic-latest.zip $(curl https://www.xonotic.org/download/ | grep 'Download as zip' | sed -E 's/.+ href="([^"]+)".+/\1/g')
COPY xonotic-0.8.2.zip /opt/xonotic-latest.zip

RUN cd /opt && unzip xonotic-latest.zip
RUN rm /opt/xonotic-latest.zip
RUN mkdir /opt/Xonotic/shared
COPY start-server.sh /opt/Xonotic/start-server.sh
COPY lighttpd.conf /etc/lighttpd/
EXPOSE 26000/tcp
EXPOSE 26000/udp
ENTRYPOINT ["/bin/bash", "/opt/Xonotic/start-server.sh"]
