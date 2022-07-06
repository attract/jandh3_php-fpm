FROM php:8.0.5-fpm-alpine

MAINTAINER AttractGroup

RUN apk update && apk add --no-cache  bash htop grep nano coreutils curl oniguruma-dev \
    libpng-dev libjpeg-turbo-dev freetype-dev libmcrypt postgresql-dev libxml2-dev libzip-dev imagemagick-dev libtool \
    composer supervisor git freetds freetds-dev libmcrypt-dev \
    icu icu-dev

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions imagick zip pdo_mysql mysqli pdo_pgsql pdo_dblib gd exif opcache intl bcmath mcrypt

RUN docker-php-ext-configure gd --with-jpeg --with-freetype && \
    docker-php-ext-configure intl

RUN set -eux; \
    apk update; \
    apk add libxml2-dev; \
    apk add php8-soap; \
    apk add libsodium libsodium-dev;

RUN docker-php-ext-install soap; \
    docker-php-ext-enable soap; \
    docker-php-ext-install sodium; \
    docker-php-ext-install tokenizer; \
    docker-php-ext-enable tokenizer; \
    docker-php-ext-enable sodium
