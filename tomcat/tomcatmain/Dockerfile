# 빌더 스테이지
FROM adoptopenjdk/openjdk11:jdk-11.0.11_9-alpine AS builder

RUN apk update && \
    apk add --no-cache wget tar

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV CATALINA_HOME=/usr/local/tomcat9.0
ENV TOMCAT_VERSION=9.0.89
ENV MYSQL_CONNECTOR_VERSION=8.0.27

RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.89/bin/apache-tomcat-9.0.89.tar.gz && \
    mkdir -p $CATALINA_HOME && \
    tar -xvf apache-tomcat-9.0.89.tar.gz -C $CATALINA_HOME --strip-components=1 && \
    rm apache-tomcat-9.0.89.tar.gz && \
    wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.27/mysql-connector-java-8.0.27.jar && \
    mv mysql-connector-java-8.0.27.jar $CATALINA_HOME/lib/ && \
    rm -rf $CATALINA_HOME/webapps/* && \
    mkdir -p $CATALINA_HOME/webapps/ROOT

COPY . $CATALINA_HOME/webapps/ROOT/

# 최종 이미지
FROM openjdk:8-jre-alpine

RUN apk add --no-cache openjdk8-jre-base && \
    rm -rf /var/cache/apk/*

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV CATALINA_HOME=/usr/local/tomcat9.0
ENV PATH=$JAVA_HOME/bin:$CATALINA_HOME/bin:$PATH

COPY --from=builder $CATALINA_HOME $CATALINA_HOME

EXPOSE 8080

CMD ["catalina.sh", "run"]
