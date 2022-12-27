FROM php:8.1-fpm

RUN apt-get update
RUN apt-get install -y libicu-dev zlib1g-dev libz-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev
RUN docker-php-ext-install mysqli pdo pdo_mysql intl
RUN docker-php-ext-enable intl mysqli
RUN pecl install redis
RUN pecl install swoole
RUN docker-php-ext-configure gd
RUN docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-enable redis swoole gd
RUN docker-php-source extract
