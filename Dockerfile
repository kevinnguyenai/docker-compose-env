ARG DOCKER_VERSION=latest
ARG MAVEN_VERSION=3.8.5-r0
ARG JAVA_VERSION=8.212.04-r1
FROM docker:${DOCKER_VERSION}

ARG COMPOSE_VERSION=
ARG DOCKER_VERSION
ARG MAVEN_VERSION=
ARG MAVEN_VERSION
ARG JAVA_VERSION=
ARG JAVA_VERSION

ENV PATH /usr/bin:$PATH

RUN apk add --no-cache py3-pip python3 maven~3.8.5 openjdk8
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
  && pip3 install "docker-compose${COMPOSE_VERSION:+==}${COMPOSE_VERSION}" \
  && apk del build-dependencies

RUN wget https://mirrors.estointernet.in/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
RUN tar -xvf apache-maven-3.6.3-bin.tar.gz
RUN mv apache-maven-3.6.3 /opt/

ENV M2_HOME=/opt/apache-maven-3.6.3
ENV JAVA_HOME=/usr/lib/jvm/default-jvm/
ENV COMBINE_PATH="${JAVA_HOME}/bin:${M2_HOME}/bin:${PATH}"
ENV PATH "${COMBINE_PATH}"

#RUN echo $PATH
#RUN ls -lt /
#RUN ls -lt /opt
#RUN ls -lt /usr/lib/jvm
#RUN mvn --version

LABEL \
  org.opencontainers.image.authors="Kevin Nguyen <kevin.nguyen.ai@gmail.com>" \
  org.opencontainers.image.description="This docker image installs docker-compose on top of the docker image." \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.source="https://github.com/kevinnguyenai/docker-compose-env" \
  org.opencontainers.image.title="Docker Compose on docker base image" \
  org.opencontainers.image.vendor="Kevin Nguyen" \
  org.opencontainers.image.version="${DOCKER_VERSION} with docker-compose ${COMPOSE_VERSION}"

