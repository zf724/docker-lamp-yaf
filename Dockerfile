FROM docker.io/php:7.1.6-apache
MAINTAINER PHP Docker Maintainers

RUN docker-php-source extract \
    && docker-php-ext-install mysqli \
    && docker-php-source delete
