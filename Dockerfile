#FROM docker-registry.int:5000/myapp_php

#RUN composer global require hirak/prestissimo

#COPY . /var/www/html/myapp


#EXPOSE 8081
################
FROM php:7.2-apache

LABEL maintainer="David Fichtenbaum"

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    zip \
    curl \
    sudo \
    unzip \
    libicu-dev \
    libbz2-dev \
    libpng-dev \
    libjpeg-dev \
    libmcrypt-dev \
    libreadline-dev \
    libfreetype6-dev \
    g++ \
    libcurl4-openssl-dev \
    && docker-php-ext-install \
    bz2 \
    intl \
    iconv \
    bcmath \
    opcache \
    calendar \
    mbstring \
    pdo_mysql \
    zip \
    curl \
    && apt-get autoclean && apt-get clean
#

RUN curl https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require hirak/prestissimo

COPY ./docker-configs/php/php.ini $PHP_INI_DIR/custom.ini
COPY ./docker-configs/httpd/app.site.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /var/www/html

COPY . /var/www/html

EXPOSE 8081

