#!/bin/bash -ex

#if [ -S ${DOCKER_SOCKET} ]; then
    DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
sed -ibak "s/:999:/:${DOCKER_GID}:/" /etc/group
sudo -u jenkins id
#    groupadd -for -g ${DOCKER_GID} docker
#    usermod -aG docker jenkins
#fi

exec sudo -E -H -u jenkins bash -c /usr/local/bin/jenkins.sh
