#!/bin/bash -x
# Install the OC things.

update-indeps() {
    sudo yum -y update
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io git
    sudo usermod -aG docker `whoami` 
    newgrp docker
}

fix-docker-net() {
    sudo mkdir /etc/{docker,containers}
    # add file cobtents
}

bounce-dockerz() {
    sudo systemctl daemon-reload
    sudo systemctl restart docker
    sudo systemctl enable docker
}

add-fwd() {
    echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
}

cfg-fw() {
    DOCKER_BRIDGE=`docker network inspect -f "{{range .IPAM.Config }}{{ .Subnet }}{{end}}" bridge`
    sudo firewall-cmd --permanent --new-zone dockerc
    sudo firewall-cmd --permanent --zone dockerc --add-source $DOCKER_BRIDGE
    sudo firewall-cmd --permanent --zone dockerc --add-port={80,443,8443}/tcp
    sudo firewall-cmd --permanent --zone dockerc --add-port={53,8053}/udp
    sudo firewall-cmd --reload
}

get-oc() {
    wget https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
    tar xvf openshift-origin-client-tools*.tar.gz
    cd openshift-origin-client*/
    sudo mv oc kubectl /usr/local/bin/
    oc version
    oc cluster up
}

update-indeps
fix-docker-net
bounce-dockerz
add-fwd
cfg-fw
get-oc
