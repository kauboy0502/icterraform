FROM ubuntu:18.04

# renovate: datasource=repology depName=ubuntu_22_04/open-jdk versioning=loose
#Install openjdk-jdk11
RUN apt-get update && \
        apt-get install -y --no-install-recommends openjdk-11-jdk-headless="11.0.19+7~us1-0ubuntu1~22.04.1" \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*
