FROM opensuse:latest
LABEL maintainer="scoday <www.scoday.jp>"
ENV ScOpenSUSE_NGINX 1.0b

RUN zypper --gpg-auto-import-keys ref -s
RUN zypper -n in vim \
                 nginx

COPY files/index.html /srv/www/htdocs/index.html
COPY files/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
