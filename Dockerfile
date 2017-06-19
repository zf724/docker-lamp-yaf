FROM docker.io/php
MAINTAINER PHP Docker Maintainers

RUN docker-php-source extract \
    && docker-php-ext-install mysqli \
    && docker-php-source delete
