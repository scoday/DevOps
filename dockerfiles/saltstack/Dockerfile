from tianon/centos:latest
MAINTAINER ScoDay.Tokyo

# EPEL
RUN rpm -Uvh --force http://mirrors.kernel.org/fedora-epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum update -y

# Install Salt Deps
RUN yum -y install --enable-repo=epel \
  python \
  PyYAML \
  m2crypto \
  python-crypto \
  python-msgpack \
  python-zmq \
  python-setuptools \

RUN easy_install \
  jinja2 \
  requests
