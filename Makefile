
REPOSITORY=cybermaggedon/hadoop
VERSION=2.7.3

SUDO=
BUILD_ARGS=

all: hadoop-2.7.3.tar.gz
	${SUDO} docker build ${BUILD_ARGS} -t ${REPOSITORY}:${VERSION} .

# FIXME: May not be the right mirror for you.
hadoop-2.7.3.tar.gz:
	wget http://mirror.catn.com/pub/apache/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz

push:
	${SUDO} docker build ${BUILD_ARGS} -t ${REPOSITORY}:${VERSION}	

