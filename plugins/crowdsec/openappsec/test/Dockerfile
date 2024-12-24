# Stage 1: Build your PHP application with PHP-FPM
FROM randyproxz/php7.4-fpm-alpine

# Install mandatory
RUN apk update
RUN apk add --no-cache nginx tzdata && rm -rf /var/cache/apk/*

RUN ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# Create the cache nginx
RUN mkdir -p /var/cache/nginx/fastcgi
RUN chown -R nginx:nginx /var/cache/nginx

# Create log file
RUN mkdir -p /var/log/php
RUN mkdir -p /var/log/nginx

# Copy your files to container
COPY ./source /usr/share/nginx/html
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf 

# Enable OpenAppSec
RUN cp /var/www/html/attachment/build_out/nginx_attachment/lib/* /usr/lib
RUN cp /var/www/html/attachment/build_out/nginx_attachment/lib/libngx_module.so /usr/lib/nginx/modules/libngx_module.so
RUN sed -i '1s|^|load_module /usr/lib/nginx/modules/libngx_module.so;\n|' /etc/nginx/nginx.conf

# RUN
CMD /usr/local/sbin/php-fpm -F & nginx -g 'daemon off;'