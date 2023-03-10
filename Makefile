
REPOSITORY=cybermaggedon/hadoop
VERSION=$(shell git describe | sed 's/^v//')
HADOOP_VERSION=3.3.4
DOCKER=docker

SUDO=
BUILD_ARGS=--build-arg HADOOP_VERSION=${HADOOP_VERSION}

all: hadoop-${HADOOP_VERSION}.tar.gz
	${SUDO} ${DOCKER} build ${BUILD_ARGS} -t ${REPOSITORY}:${VERSION} .

# FIXME: May not be the right mirror for you.
hadoop-${HADOOP_VERSION}.tar.gz:
	wget -O $@ http://www.mirrorservice.org/sites/ftp.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz

push:
	${SUDO} ${DOCKER} push ${REPOSITORY}:${VERSION}

