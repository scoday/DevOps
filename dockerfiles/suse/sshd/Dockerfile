# Pull the latest OpenSuSE
FROM opensuse:leap
MAINTAINER ScoDay

RUN \
    zypper --gpg-auto-import-keys ref -s && \
    zypper -in in && \
    zypper install -y openssh && \
    mkdir /var/run/sshd && \
    echo 'root:foobar' | chgpasswd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "export VISIBLE=now" >> /etc/profile

ENV NOTVISIBLE "in users profile"

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
