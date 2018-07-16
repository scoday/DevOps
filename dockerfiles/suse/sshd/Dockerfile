# Pull the latest OpenSuSE
FROM opensuse:leap
MAINTAINER ScoDay

RUN \
    zypper --gpg-auto-import-keys ref -s && \
    zypper -in in \
        openssh && \
    # Do some things && stuff
    mkdir /var/run/sshd && \
    echo -e 'foobar123\nfoobar123\n' | passwd root && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "export VISIBLE=now" >> /etc/profile

COPY files/sshd_config /etc/sshd_config
ENV NOTVISIBLE "in users profile"

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
