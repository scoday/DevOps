# vagrant-ceph-docker

This repo contains the configuration files to test the docker images created in the https://github.com/ceph/ceph-docker project.

Vagrant will instantiate three VMs using an `opensuse/openSUSE-42.1-x86_64`(default) or `yk0/ubuntu-xenial` box, will automatically provision the VMs with docker and will build the ceph-docker images of the flavor defined in the settings file.


## Setting up configuration

Configuration resides in the `settings.yml` file that contains the custom configuration to spin up the cluster, and choose which ceph-docker images flavor to build and test. See [`settings.sample.yml`](settings.sample.yml) for an example of the `settings.yml` that you must create.

### Settings options:

| Option |  Type    | Default
|----------| ----------| --------|
| `vagrant_box` | string | `opensuse/openSUSE-42.1-x86_64` |
| `ceph_docker_repo` | URL | `https://github.com/rjfd/ceph-docker.git`|
| `ceph_docker_branch` | string | `wip-opensuse-test` |
| `ceph_docker_ceph_version` | string | `jewel` |
| `ceph_docker_distro` | string | `opensuse`
| `ceph_docker_distro_version` | string | `Leap_42.2`|
| `libvirt_host` | IP address | None |
| `libvirt_user` | string | None |
| `libvirt_use_ssl` | boolean | None |
| `vm_memory` | integer |  `4096` |
| `vm_cpus`| integer |  `2` |
| `vm_storage_pool` | string | none |
| `vm_num_volumes` | integer |  `2`
| `vm_volume_size` |  binary size | `8G`

Vagrant will create three VMs, and each VM configuration is controlled by the `vm_*` options.

## Spin up cluster

Just run `vagrant up` and wait a few minutes.

## Deploying a Ceph cluster using the docker images

SSH into the VM `node1` like this `vagrant ssh node1`.
Inside the VM there are some bash scripts to deploy and undeploy a Ceph cluster.

The `deploy_cluster.sh` script will deploy 3 monitors, 3 OSDs, 1 MDS in node2, and 1 RGW in node1.

The `undeploy_cluster.sh` will delete all the containers and reset the shared directories used by the Ceph daemons.

## Issuing commands to the Ceph cluster

After deploying a Ceph cluster, you can issue commands to the cluster using the `run_ceph_cmd.sh` script.

Example:
`./run_ceph_cmd.sh ceph -s`

