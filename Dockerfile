FROM ubuntu:22.04

# renovate: datasource=custom depName=nodejs versioning=deb
ENV NODE_VERSION="16.17.1-deb-1nodesource1"
RUN apt-get update && \
 curl -L https://deb.nodesource.com/setup_16.x | bash && \
 apt-get install -y --no-install-recommends nodejs="$NODE_VERSION"
