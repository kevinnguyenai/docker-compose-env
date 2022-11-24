ARG DOCKER_VERSION=latest
ARG MAVEN_VERSION=3.8.5-r0
ARG JAVA_VERSION=8
FROM docker:${DOCKER_VERSION}

ARG COMPOSE_VERSION=
ARG DOCKER_VERSION
ARG MAVEN_VERSION=
ARG MAVEN_VERSION
ARG JAVA_VERSION=
ARG JAVA_VERSION

ENV PATH /usr/bin:$PATH

RUN apk add --no-cache py3-pip python3
RUN apk add --no-cache --virtual \
  build-dependencies \
  cargo \
  gcc \
  libc-dev \
  libffi-dev \
  make \
  openssl-dev \
  python3-dev \
  rust \
  "maven=${MAVEN_VERSION}" \
  "openjdk${JAVA_VERSION}" \
  && pip3 install "docker-compose${COMPOSE_VERSION:+==}${COMPOSE_VERSION}" \
  && apk del build-dependencies

LABEL \
  org.opencontainers.image.authors="Kevin Nguyen <kevin.nguyen.ai@gmail.com>" \
  org.opencontainers.image.description="This docker image installs docker-compose on top of the docker image." \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.source="https://github.com/kevinnguyenai/docker-compose-env" \
  org.opencontainers.image.title="Docker Compose on docker base image" \
  org.opencontainers.image.vendor="Kevin Nguyen" \
  org.opencontainers.image.version="${DOCKER_VERSION} with docker-compose ${COMPOSE_VERSION}"
