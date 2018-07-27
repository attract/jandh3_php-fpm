FROM php:7.0-fpm

MAINTAINER AttractGroup

RUN apt-get update && apt-get install -y \
        libssl-dev \
        libxml2-dev \
        git \
        mysql-client \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        imagemagick \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install \
        mysqli \
        soap \
        mbstring \
        pdo \
        pdo_mysql

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=root --with-fpm-group=root

# ZipArchive: #
RUN docker-php-ext-install zip && \
    docker-php-ext-enable zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# для ускорения composer install
RUN composer global require "hirak/prestissimo:^0.3"
