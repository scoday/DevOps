FROM opensuse:latest

RUN zypper --gpg-auto-import-keys ref -s
RUN zypper -n in vim
RUN zypper -n in nginx

COPY index.html /srv/www/htdocs/index.html
