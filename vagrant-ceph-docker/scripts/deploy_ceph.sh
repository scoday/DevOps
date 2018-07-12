#!/bin/bash

if [[ "$1" == "mon" || "$1" == "" ]]; then

docker run -d --net=host -v /etc/ceph:/etc/ceph \
           --name ceph-mon \
           -v /var/lib/ceph:/var/lib/ceph \
           -e MON_IP=192.168.100.201 \
           -e CEPH_PUBLIC_NETWORK=192.168.100.0/24 \
            ceph/daemon mon

sudo scp -r /etc/ceph node2:/etc/ceph
sudo scp -r /var/lib/ceph node2:/var/lib/ceph
sudo ssh node2 'rm -rf /var/lib/ceph/mon'

sudo scp -r /etc/ceph node3:/etc/ceph
sudo scp -r /var/lib/ceph node3:/var/lib/ceph
sudo ssh node3 'rm -rf /var/lib/ceph/mon'

sleep 5

ssh node2 <<HERE
docker run -d --net=host -v /etc/ceph:/etc/ceph \
           --name ceph-mon \
           -v /var/lib/ceph:/var/lib/ceph \
           -e MON_IP=192.168.100.202 \
           -e CEPH_PUBLIC_NETWORK=192.168.100.0/24 \
            ceph/daemon mon
HERE

ssh node3 <<HERE
docker run -d --net=host -v /etc/ceph:/etc/ceph \
           --name ceph-mon \
           -v /var/lib/ceph:/var/lib/ceph \
           -e MON_IP=192.168.100.203 \
           -e CEPH_PUBLIC_NETWORK=192.168.100.0/24 \
            ceph/daemon mon
HERE
fi

if [[ "$1" == "" ]]; then
sleep 5
fi


if [[ "$1" == "osd" || "$1" == "" ]]; then

docker run -d --net=host -v /etc/ceph/:/etc/ceph/ \
           -v /var/lib/ceph/:/var/lib/ceph/ \
           -v /dev/:/dev/ \
           --privileged=true \
           -e OSD_FORCE_ZAP=1 \
           -e OSD_DEVICE=/dev/vdb \
           ceph/daemon osd_ceph_disk

docker run -d --net=host -v /etc/ceph/:/etc/ceph/ \
           -v /var/lib/ceph/:/var/lib/ceph/ \
           -v /dev/:/dev/ \
           --privileged=true \
           -e OSD_FORCE_ZAP=1 \
           -e OSD_DEVICE=/dev/vdc \
           ceph/daemon osd_ceph_disk

ssh node2 <<HERE
docker run -d --net=host -v /etc/ceph/:/etc/ceph/ \
           -v /var/lib/ceph/:/var/lib/ceph/ \
           -v /dev/:/dev/ \
           --privileged=true \
           -e OSD_FORCE_ZAP=1 \
           -e OSD_DEVICE=/dev/vdb \
           ceph/daemon osd_ceph_disk

docker run -d --net=host -v /etc/ceph/:/etc/ceph/ \
           -v /var/lib/ceph/:/var/lib/ceph/ \
           -v /dev/:/dev/ \
           --privileged=true \
           -e OSD_FORCE_ZAP=1 \
           -e OSD_DEVICE=/dev/vdc \
           ceph/daemon osd_ceph_disk
HERE

ssh node3 <<HERE
docker run -d --net=host -v /etc/ceph/:/etc/ceph/ \
           -v /var/lib/ceph/:/var/lib/ceph/ \
           -v /dev/:/dev/ \
           --privileged=true \
           -e OSD_FORCE_ZAP=1 \
           -e OSD_DEVICE=/dev/vdb \
           ceph/daemon osd_ceph_disk

docker run -d --net=host -v /etc/ceph/:/etc/ceph/ \
           -v /var/lib/ceph/:/var/lib/ceph/ \
           -v /dev/:/dev/ \
           --privileged=true \
           -e OSD_FORCE_ZAP=1 \
           -e OSD_DEVICE=/dev/vdc \
           ceph/daemon osd_ceph_disk
HERE
fi

if [[ "$1" == "" ]]; then
sleep 5
fi

if [[ "$1" == "mds" || "$1" == "" ]]; then
docker run -d --net=host -v /etc/ceph/:/etc/ceph/ \
           -v /var/lib/ceph/:/var/lib/ceph/ \
           -e CEPHFS_CREATE=1 \
           ceph/daemon mds
fi

if [[ "$1" == "rgw" || "$1" == "" ]]; then
ssh node2 <<HERE
docker run -d --net=host -v /etc/ceph/:/etc/ceph/ \
           -v /var/lib/ceph/:/var/lib/ceph/ \
           ceph/daemon rgw
HERE
fi

