FROM php:7.4-fpm-alpine

MAINTAINER AttractGroup

RUN apk upgrade --update
RUN apk add nano
RUN apk add bash
RUN apk add coreutils
RUN apk add freetype-dev
RUN apk add libjpeg-turbo-dev
RUN apk add libmcrypt-dev
RUN apk add libpng-dev
RUN apk add curl
RUN apk add libmemcached-dev
RUN apk add git
RUN apk add mysql-client
RUN apk add postgresql-dev
RUN apk add zlib-dev
RUN apk add icu-dev
RUN apk add supervisor
RUN apk add imap-dev
RUN apk add unzip
RUN apk add krb5-dev
RUN apk add libzip-dev
RUN apk add libxml2-dev
RUN apk add oniguruma-dev
RUN apk add imagemagick

RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) json mbstring zip pdo pdo_mysql mysqli pdo_pgsql iconv gd exif xml opcache tokenizer ctype bcmath intl exif imap


RUN apk add --update --no-cache autoconf g++ make
RUN pecl install redis
RUN docker-php-ext-enable redis

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer global require "hirak/prestissimo:^0.3"