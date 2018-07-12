#!/bin/bash

DISTRO=`sed -rn 's/^ID=(.*)/\1/p' /etc/os-release`
if [ "opensuse" = "$DISTRO" ]
then
  zypper addrepo \
    https://yum.dockerproject.org/repo/main/opensuse/13.2/ \
    docker-main
  zypper --no-gpg-checks refresh
  zypper -n --no-gpg-checks install docker-engine
else
  apt-get install -y docker.io
fi
