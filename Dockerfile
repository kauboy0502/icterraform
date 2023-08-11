FROM ubuntu:22.04

RUN apt-get update 
# renovate: datasource=repology depName=ubuntu_22_04/openjdk versioning=deb
ENV JAVA_VERSION="11.0.19+7~us1-0ubuntu1~22.04.1"


RUN apt-get install -y --no-install-recommends openjdk-11-jdk-headless="$JAVA_VERSION" \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*
