FROM opensuse:leap
MAINTAINER ScoDay.Tokyo

RUN zypper ref && \
    zypper -n in salt-master python-MySQL-python && \
    zypper clean -a

RUN useradd -MNrs /bin/false saltapi

ARG password
#RUN echo "saltapi:saltapi" | chpasswd
RUN sh -c "echo saltapi:${password:-ScottDay12345} | chpasswd"

CMD salt-master
