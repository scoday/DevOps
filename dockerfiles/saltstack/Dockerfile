FROM opensuse:leap
MAINTAINER ScoDay.JP

RUN zypper ref && \
    zypper -n in salt-cloud salt-master python-MySQL-python && \
    zypper clean -a

RUN useradd -MNrs /bin/false saltapi

ARG password
#RUN echo "saltapi:saltapi" | chpasswd
RUN sh -c "echo saltapi:${password:-ScottDay12345} | chpasswd"

COPY 
CMD salt-master
