# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

raise Vagrant::Errors::VagrantError.new, 
  "'settings.yml' file not found.\n\n" \
  "Please define your 'settings.yml'. " \
  "See 'settings.sample.yml' for an example." unless File.exist?("settings.yml")

settings = YAML.load_file('settings.yml')

vagrant_box = settings.has_key?('vagrant_box') ?
                     settings['vagrant_box'] : "opensuse/openSUSE-42.1-x86_64"

ceph_docker_repo = settings.has_key?('ceph_docker_repo') ?
                   settings['ceph_docker_repo'] :
                   "https://github.com/rjfd/ceph-docker.git"
ceph_docker_branch = settings.has_key?('ceph_docker_branch') ?
                     settings['ceph_docker_branch'] : "wip-opensuse"

ceph_docker_ceph_version = settings.has_key?('ceph_docker_ceph_version') ?
                           settings['ceph_docker_ceph_version'] : "jewel"
ceph_docker_distro = settings.has_key?('ceph_docker_distro') ?
                     settings['ceph_docker_distro'] : "opensuse"
ceph_docker_distro_version = settings.has_key?('ceph_docker_distro_version') ?
                     settings['ceph_docker_distro_version'] : "Leap_42.2"

Vagrant.configure("2") do |config|
  config.vm.box = vagrant_box

  config.vm.provider "libvirt" do |lv|
    if settings.has_key?('libvirt_host') then
      lv.host = settings['libvirt_host']
    end
    if settings.has_key?('libvirt_user') then
      lv.username = settings['libvirt_user']
    end
    if settings.has_key?('libvirt_use_ssl') then
      lv.connect_via_ssh = true
    end

    lv.memory = settings.has_key?('vm_memory') ? settings['vm_memory'] : 4096
    lv.cpus = settings.has_key?('vm_cpus') ? settings['vm_cpus'] : 2
    if settings.has_key?('vm_storage_pool') then
      lv.storage_pool_name = settings['vm_storage_pool']
    end

    num_volumes = settings.has_key?('vm_num_volumes') ?
                  settings['vm_num_volumes'] : 2
    volume_size = settings.has_key?('vm_volume_size') ?
                  settings['vm_volume_size'] : '8G'
    (1..num_volumes).each do |d|
      lv.storage :file, size: volume_size, type: 'raw'
    end

  end

  config.vm.define :node1 do |node|
    node.vm.hostname = "node1"
    node.vm.network :private_network, ip: "192.168.100.201"

    node.vm.provision "file", source: "keys/id_rsa",
                              destination:".ssh/id_rsa"
    node.vm.provision "file", source: "keys/id_rsa.pub",
                              destination:".ssh/id_rsa.pub"
    node.vm.provision "file", source: "scripts/deploy_ceph.sh",
                              destination:"deploy_ceph.sh"
    node.vm.provision "file", source: "scripts/undeploy_ceph.sh",
                              destination:"undeploy_ceph.sh"
    node.vm.provision "file", source: "scripts/run_ceph_cmd.sh",
                              destination:"run_ceph_cmd.sh"
    node.vm.provision "file", source: "scripts/rebuild_docker_images.sh",
                              destination:"rebuild_docker_images.sh"
    node.vm.provision "file", source: "scripts/rgw_test.sh",
                              destination:"rgw_test.sh"
    node.vm.provision "file", source: "scripts/install_docker.sh",
                              destination:"install_docker.sh"

    node.vm.provision "shell", inline: <<-SHELL
      echo "192.168.100.201 node1" >> /etc/hosts
      echo "192.168.100.202 node2" >> /etc/hosts
      echo "192.168.100.203 node3" >> /etc/hosts
      cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
      mkdir /root/.ssh
      chmod 600 /home/vagrant/.ssh/id_rsa
      cp /home/vagrant/.ssh/id_rsa* /root/.ssh/
      cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

      sed -i -e 's!@CEPH_DOCKER_REPO@!#{ceph_docker_repo}!g' \
             -e 's/@CEPH_DOCKER_BRANCH@/#{ceph_docker_branch}/g' \
             -e 's/@CEPH_DOCKER_CEPH_VERSION@/#{ceph_docker_ceph_version}/g' \
             -e 's/@CEPH_DOCKER_DISTRO@/#{ceph_docker_distro}/g' \
             -e 's/@CEPH_DOCKER_DISTRO_VERSION@/#{ceph_docker_distro_version}/g' \
             rebuild_docker_images.sh

      apt-get update
      ./install_docker.sh
      apt-get install -y pv
      gpasswd -a vagrant docker
      sudo systemctl enable docker
      sudo systemctl restart docker
      cd /home/vagrant
      git clone #{ceph_docker_repo}
      pushd ceph-docker
      git checkout #{ceph_docker_branch}
      ./generate-dev-env.sh #{ceph_docker_ceph_version} #{ceph_docker_distro} \
                            #{ceph_docker_distro_version}
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

      while [[ `ls -l /tmp/ready-* 2>/dev/null | wc -l` != "2" ]]; do
        sleep 2; echo "scp... node2 ... node3";
        scp -o StrictHostKeyChecking=no node2:/tmp/ready /tmp/ready-node2;
        scp -o StrictHostKeyChecking=no node3:/tmp/ready /tmp/ready-node3;
      done

      docker save base | bzip2 | pv | ssh node2 'bunzip2 | docker load'
      docker save base | bzip2 | pv | ssh node3 'bunzip2 | docker load'
      docker save ceph/daemon | bzip2 | pv | ssh node2 'bunzip2 | docker load'
      docker save ceph/daemon | bzip2 | pv | ssh node3 'bunzip2 | docker load'

    SHELL
  end

  config.vm.define :node2 do |node|
    node.vm.hostname = "node2"
    node.vm.network :private_network, ip: "192.168.100.202"

    node.vm.provision "file", source: "keys/id_rsa",
                              destination:".ssh/id_rsa"
    node.vm.provision "file", source: "keys/id_rsa.pub",
                              destination:".ssh/id_rsa.pub"
    node.vm.provision "file", source: "scripts/install_docker.sh",
                              destination:"install_docker.sh"

    node.vm.provision "shell", inline: <<-SHELL
      echo "192.168.100.201 node1" >> /etc/hosts
      echo "192.168.100.202 node2" >> /etc/hosts
      echo "192.168.100.203 node3" >> /etc/hosts
      cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
      mkdir /root/.ssh
      chmod 600 /home/vagrant/.ssh/id_rsa
      cp /home/vagrant/.ssh/id_rsa* /root/.ssh/
      cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

      ssh-keyscan -H node1 >> ~/.ssh/known_hosts
      ssh-keyscan -H node3 >> ~/.ssh/known_hosts
      apt-get update
      ./install_docker.sh
      gpasswd -a vagrant docker
      sudo systemctl enable docker
      sudo systemctl restart docker
      touch /tmp/ready
    SHELL
  end

  config.vm.define :node3 do |node|
    node.vm.hostname = "node3"
    node.vm.network :private_network, ip: "192.168.100.203"

    node.vm.provision "file", source: "keys/id_rsa",
                              destination:".ssh/id_rsa"
    node.vm.provision "file", source: "keys/id_rsa.pub",
                              destination:".ssh/id_rsa.pub"
    node.vm.provision "file", source: "scripts/install_docker.sh",
                              destination:"install_docker.sh"

    node.vm.provision "shell", inline: <<-SHELL
      echo "192.168.100.201 node1" >> /etc/hosts
      echo "192.168.100.202 node2" >> /etc/hosts
      echo "192.168.100.203 node3" >> /etc/hosts
      cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
      mkdir /root/.ssh
      chmod 600 /home/vagrant/.ssh/id_rsa
      cp /home/vagrant/.ssh/id_rsa* /root/.ssh/
      cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

      ssh-keyscan -H node1 >> ~/.ssh/known_hosts
      ssh-keyscan -H node2 >> ~/.ssh/known_hosts
      apt-get update
      ./install_docker.sh
      gpasswd -a vagrant docker
      sudo systemctl enable docker
      sudo systemctl restart docker
      touch /tmp/ready
    SHELL
  end

end
