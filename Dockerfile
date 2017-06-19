FROM docker.io/php:7.1.6
MAINTAINER PHP Docker Maintainers

RUN docker-php-source extract \
    && docker-php-ext-install mysqli \
    && docker-php-source delete

ADD https://raw.githubusercontent.com/zf724/docker-php/master/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME /var/www/html
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
