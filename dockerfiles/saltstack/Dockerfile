FROM opensuse:leap
MAINTAINTER ScoDay.Tokyo

RUN zypper ref && \
    zypper -n in salt-master python-MySQL-python && \
    zypper clean -a

RUN useradd -MNrs /bin/false saltapi
RUN echo "saltapi:saltapi" | chpasswd

CMD salt-master
