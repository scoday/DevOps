# Pull the latest OpenSUSE
FROM opensuse:leap

# Install a few things for bind and 
# change the permissions on the working dir.
RUN \
  zypper --gpg-auto-import-keys ref -s && \
  zypper -in in \
    bind \
    bind-libs \
    bind-utils && \
    chown -R named:named /var/lib/named

# Copy over some required files:
# * named.conf.local = config file from existing system
COPY files/named.conf.local /var/lib/named/etc/named.conf.local
# * zones = zones from existing system
COPY files/zones/* /var/lib/named/master/
# Modified sysconfig/named to stop the chroot settings
COPY files/named.sysconfig /etc/sysconfig/named
# Simple script that should just fire up named
COPY files/start.sh /start.sh

CMD ["/start.sh"]

EXPOSE 53/udp
