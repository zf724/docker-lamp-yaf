FROM docker.io/php:5.6.30-apache
MAINTAINER PHP Docker Maintainers

RUN docker-php-source extract \
    && docker-php-ext-install mysqli \
    && docker-php-source delete

WORKDIR /var/www/html

#ADD https://raw.githubusercontent.com/zf724/docker-php/master/config/php.ini /usr/local/etc/php/

VOLUME /var/www/html
EXPOSE 80
