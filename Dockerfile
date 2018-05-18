FROM ubuntu:latest

ENV TC_VER 8.5.31
ENV TC_PREFIX /usr/local/tomcat

RUN apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install \
  openjdk-8-jdk \
  wget \
  less \
  && wget http://www-us.apache.org/dist/tomcat/tomcat-8/v${TC_VER}/bin/apache-tomcat-${TC_VER}.tar.gz \
  -O /tmp/tomcat.tar.gz \
  && mkdir ${TC_PREFIX} \ 
  && tar -zxvf /tmp/tomcat.tar.gz -C /tmp \
  && cp -Rv /tmp/apache-tomcat-${TC_VER}/* ${TC_PREFIX}/ \
  && rm -f /tmp/tomcat.tar.gz \
  && useradd -d /usr/local/tomcat -c Tomcat8 -s /bin/bash -M tomcat8

RUN chown -R tomcat8:tomcat8 ${TC_PREFIX} \ 
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/*

EXPOSE 8080

USER tomcat8

CMD /usr/local/tomcat/bin/catalina.sh run 

