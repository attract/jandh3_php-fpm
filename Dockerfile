FROM php:5.5-fpm

MAINTAINER AttractGroup

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libssl-dev \
    libmcrypt-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    git

RUN docker-php-ext-install \
    mysql \
    mcrypt \
    soap \
    gd \
    mbstring

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=root --with-fpm-group=root

# ZipArchive: #
RUN pecl install zip && \
    docker-php-ext-enable zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
