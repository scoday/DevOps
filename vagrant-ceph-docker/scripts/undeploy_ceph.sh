#!/bin/bash

docker stop `docker ps --no-trunc -q`
docker rm `docker ps --no-trunc -aq`
sudo rm -rf /etc/ceph
sudo rm -rf /var/lib/ceph

ssh node2 <<HERE
docker stop \`docker ps --no-trunc -q\`
docker rm \`docker ps --no-trunc -aq\`
sudo rm -rf /etc/ceph
sudo rm -rf /var/lib/ceph
HERE

ssh node3 <<HERE
docker stop \`docker ps --no-trunc -q\`
docker rm \`docker ps --no-trunc -aq\`
sudo rm -rf /etc/ceph
sudo rm -rf /var/lib/ceph
HERE

