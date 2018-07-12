#!/bin/bash

for i in 1 2 3; do
  ssh node$i 'docker rmi ceph/daemon base ceph/demo'
done

cd /home/vagrant
rm -rf ceph-docker
git clone @CEPH_DOCKER_REPO@
pushd ceph-docker
git checkout @CEPH_DOCKER_BRANCH@
./generate-dev-env.sh @CEPH_DOCKER_CEPH_VERSION@ @CEPH_DOCKER_DISTRO@ \
                      @CEPH_DOCKER_DISTRO_VERSION@
pushd base
docker build -t base .
rm -rf base
popd
pushd daemon
sed -i 's|FROM .*|FROM base|g' Dockerfile
docker build -t ceph/daemon .
rm -rf daemon
popd
pushd demo
sed -i 's|FROM .*|FROM base|g' Dockerfile
docker build -t ceph/demo .
rm -rf demo
popd
popd
chown -R vagrant:vagrant ceph-docker

docker save base | bzip2 | pv | ssh node2 'bunzip2 | docker load'
docker save base | bzip2 | pv | ssh node3 'bunzip2 | docker load'
docker save ceph/daemon | bzip2 | pv | ssh node2 'bunzip2 | docker load'
docker save ceph/daemon | bzip2 | pv | ssh node3 'bunzip2 | docker load'

