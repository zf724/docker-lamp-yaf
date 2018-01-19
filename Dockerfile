FROM php:5-apache
MAINTAINER PHP Docker Maintainers

RUN docker-php-source extract \
    && docker-php-ext-install mysql mysqli pdo pdo_mysql\
    && docker-php-source delete

RUN set -xe \
    && mv /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

WORKDIR /var/www/html

VOLUME /var/www/html
EXPOSE 80
