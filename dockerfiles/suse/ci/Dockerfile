# Pull latest opensuse
FROM opensuse:leap
MAINTAINER ScoDay

# Try some zypper fu from the SuSE team:
RUN zypper ar -Gf http://download.opensuse.org/repositories/Virtualization:/containers/openSUSE_Leap_42.2/ containers && \
    zypper ref && \
    zypper -n in etcd && \
    zypper clean -a
