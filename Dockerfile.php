FROM alpine:3.17

RUN apk update && apk upgrade
RUN apk add \
    bash \
    nginx \
    php81 \
    php81-common \
    php81-dev \
    php81-gd \
    php81-xmlreader \
    php81-bcmath \
    php81-ctype \
    php81-curl \
    php81-exif \
    php81-iconv \
    php81-intl \
    php81-mbstring \
    php81-mysqli \
    php81-opcache \
    php81-openssl \
    php81-pcntl \
    php81-phar \
    php81-session \
    php81-xml \
    php81-xsl \
    php81-zip \
    php81-zlib \
    php81-dom \
    php81-fpm \
    php81-sodium \
    # Iconv Fix
    php81-pecl-apcu

RUN mkdir -p /var/run/php

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY nginx/nginx.conf /etc/nginx
COPY nginx/conf.d/php.conf /etc/nginx/conf.d/default.conf
COPY app/php/conf /etc/php81
COPY app/php/public /usr/share/nginx/html

EXPOSE 80

CMD ["/bin/bash", "-c", "php-fpm81 && chmod 777 /var/run/php/php81-fpm.sock && chmod 755 /usr/share/nginx/html/* && nginx -g 'daemon off;'"]