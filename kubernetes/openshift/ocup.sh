#!/bin/bash -x
# For turning up the OC Cluster
#
# Some Notes on OC UP:
# oc cluster up --public-hostname="${public_hostname}" --routing-suffix="${public_ip}.nip.io"
# metadata_endpoint="http://169.254.169.254/latest/meta-data"
# public_hostname="$( curl "${metadata_endpoint}/public-hostname" )"
# public_hostname="fra-kubix02.akubikubi.corp"
# public_ip="192.168.100.51"


vm-up() {
        public_hostname="fra-kubix02.akubikubi.corp"
        public_ip="192.168.100.51"
        sudo oc cluster up --public-hostname="${public_hostname}"
}

vm-up
