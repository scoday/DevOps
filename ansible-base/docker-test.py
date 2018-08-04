#!/usr/bin/python
# Modify this to use suse / ubuntu / etc.
docker run -d -p 2222:22 --name ansible_test \
    -v ~/.ssh/id_rsa.pub:/home/ubuntu/.ssh/authorized_keys \
    philm/ansible_target:ubuntu1404
