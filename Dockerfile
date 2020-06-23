FROM php:7.4-fpm

MAINTAINER AttractGroup

RUN apt-get update && apt-get install -y \
        libssl-dev \
        libxml2-dev \
        git \
        default-mysql-client \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libonig-dev \
        imagemagick \
        trimage \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install \
        mysqli \
        soap \
        pdo \
        pdo_mysql

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=root --with-fpm-group=root

# mcrypt: #
RUN apt-get update -y && \
    apt-get install -y libmcrypt-dev && \
    pecl install mcrypt-1.0.3 && \
    docker-php-ext-enable mcrypt

# ZipArchive: #
RUN apt-get install -y \
        libzip-dev \
        zip \
  && docker-php-ext-install zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# для ускорения composer install
RUN composer global require "hirak/prestissimo:^0.3"