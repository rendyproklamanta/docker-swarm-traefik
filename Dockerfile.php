FROM alpine:3.17

RUN apk update && apk upgrade
RUN apk add bash
RUN apk add nginx
RUN apk add php81 php81-fpm php81-opcache
RUN apk add php81-gd php81-zlib php81-curl

COPY nginx/nginx.conf /etc/nginx
COPY nginx/conf.d/php.conf /etc/nginx/conf.d
COPY php/conf /etc/php81
COPY php/public /usr/share/nginx/html

RUN mkdir /var/run/php

EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM

CMD ["/bin/bash", "-c", "php-fpm81 && chmod 777 /var/run/php/php81-fpm.sock && chmod 755 /usr/share/nginx/html/* && nginx -g 'daemon off;'"]