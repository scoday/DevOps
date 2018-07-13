FROM opensuse:latest

RUN \
  zypper --gpg-auto-import-keys ref -s && \
  zypper -in in bind bind-libs bind-utils

COPY files/named.conf.local /var/lib/named/etc/named.conf.local
COPY files/zones/* /var/lib/named/master/
COPY files/start.sh /start.sh

CMD ["./start.sh"]

EXPOSE 53
