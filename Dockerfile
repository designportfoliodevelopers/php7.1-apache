FROM php:7.1-apache

# Give Apache/PHP write permissions /var/www/html
ENV BOOT2DOCKER_ID 1000
RUN usermod -u ${BOOT2DOCKER_ID} www-data

# Enable mod_rewrite for pretty URLs
RUN a2enmod rewrite

# Install and configure Concrete5 dependencies
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libmcrypt-dev

RUN docker-php-ext-install mysqli pdo_mysql

RUN docker-php-ext-install zip

RUN docker-php-ext-install mcrypt \
        && docker-php-ext-enable mcrypt

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd
