### STAGE 1: Build ###
FROM php:7.4-fpm-alpine as build

WORKDIR /var/www/html

# Setup GD extension
RUN apk add --no-cache \
      freetype \
      libjpeg-turbo \
      libpng \
      freetype-dev \
      libjpeg-turbo-dev \
      libpng-dev \
    && docker-php-ext-configure gd \
      --with-freetype=/usr/include/ \
      --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-enable gd \
    && apk del --no-cache \
      freetype-dev \
      libjpeg-turbo-dev \
      libpng-dev \
    && rm -rf /tmp/*

RUN apk add libzip-dev
RUN docker-php-ext-install pdo pdo_mysql zip bcmath
COPY . .

### STAGE 2: NGINX ###
FROM nginx:stable-alpine
COPY --from=build /var/www/html /usr/share/nginx/html/
RUN rm /etc/nginx/conf.d/*
COPY nginx.conf /etc/nginx/conf.d/

EXPOSE 9000
CMD ["nginx", "-g", "daemon off;"]