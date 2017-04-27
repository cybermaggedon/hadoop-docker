
REPOSITORY=cybermaggedon/hadoop
VERSION=2.8.0
HADOOP_VERSION=2.8.0

SUDO=
BUILD_ARGS=--build-arg HADOOP_VERSION=${HADOOP_VERSION}

all: hadoop-${HADOOP_VERSION}.tar.gz
	${SUDO} docker build ${BUILD_ARGS} -t ${REPOSITORY}:${VERSION} .

# FIXME: May not be the right mirror for you.
hadoop-${HADOOP_VERSION}.tar.gz:
	wget http://mirror.catn.com/pub/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz

push:
	${SUDO} docker push ${REPOSITORY}:${VERSION}

