ARG BASE_IMAGE="Ubuntu"
ARG BASE_IMAGE_TAG="20.04"

# Use the official Ubuntu 20.04 LTS as the base image
FROM ${BASE_IMAGE}:${BASE_IMAGE_TAG}

LABEL com.alteryx.golden-container-base-images.ayx-node.node.version="16.x"
LABEL description="golden docker image for node 16 version" 

# renovate: datasource=repology depName=ubuntu_22_04/nodejs versioning=loose

# Update the package lists and install necessary dependencies
RUN apt-get update && \
 curl -L https://deb.nodesource.com/setup_16.x | bash && \
 apt-get install -y --no-install-recommends nodejs="16.20.2-deb-1nodesource1" && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
 groupadd nonroot && \
 useradd --gid nonroot nodeuser

# Switching to non root user
USER nodeuser

# Specify the command to run your application
CMD ["node"]
