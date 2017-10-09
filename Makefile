
REPOSITORY=cybermaggedon/hadoop
VERSION=2.8.1
HADOOP_VERSION=2.8.1

SUDO=
BUILD_ARGS=--build-arg HADOOP_VERSION=${HADOOP_VERSION}

all: hadoop-${HADOOP_VERSION}.tar.gz
	${SUDO} docker build ${BUILD_ARGS} -t ${REPOSITORY}:${VERSION} .

# FIXME: May not be the right mirror for you.
hadoop-${HADOOP_VERSION}.tar.gz:
	wget -O $@ 'https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz'

push:
	${SUDO} docker push ${REPOSITORY}:${VERSION}

