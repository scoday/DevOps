#!/bin/bash

RGW_USER=foo
RGW_CONTAINER_ID=`docker ps | grep rgw | cut -f 1 -d ' '`

if [[ "$RGW_CONTAINER_ID" != "" ]]; then
  sudo apt-get install -y libs3-2

  docker exec $RGW_CONTAINER_ID radosgw-admin user create \
                                --uid=$RGW_USER \
                                --display-name=$RGW_USER > \
                                    /tmp/rgw.user.${RGW_USER}.info

  RGW_ACCESS_KEY=`cat /tmp/rgw.user.${RGW_USER}.info | \
                  grep access_key | sed 's/.*"access_key": "\(.*\)".*/\1/'`
  RGW_SECRET_KEY=`cat /tmp/rgw.user.${RGW_USER}.info | \
                  grep secret_key | sed 's/.*"secret_key": "\(.*\)".*/\1/'`


  echo "*** Run the following commands to test RGW ***"
  echo ""
  echo "export S3_HOSTNAME=`hostname`:8080"
  echo "export S3_ACCESS_KEY_ID=$RGW_ACCESS_KEY"
  echo "export S3_SECRET_ACCESS_KEY=$RGW_SECRET_KEY"
  echo "s3 -us list"
  echo "s3 -us create foobar"
  echo "s3 -us put foobar/file1 filename=<file_name>"
  echo "s3 -us list foobar"

else
  echo "ERROR: could not find RGW container"
fi

