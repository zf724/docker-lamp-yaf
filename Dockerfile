FROM php:5-apache
MAINTAINER PHP Docker Maintainers

RUN docker-php-source extract \
    && docker-php-ext-install mysql mysqli pdo pdo_mysql\
    && docker-php-source delete

#RUN pecl install redis \
#    && pecl install xdebug \
#    && docker-php-ext-enable redis xdebug

RUN curl -fsSL 'http://pecl.php.net/get/yaf-2.3.5.tgz' -o yaf.tgz \
    && mkdir -p yaf \
    && tar -xf yaf.tgz -C yaf --strip-components=1 \
    && rm yaf.tgz \
    && ( \
        cd yaf \
        && phpize \
        && ./configure --with-php-config=/usr/local/bin/php-config \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r yaf \
    && docker-php-ext-enable yaf

RUN set -xe \
    && mv /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

COPY example-www/web01/l.php /var/www/html/l.php
COPY example-www/web02/phpinfo.php /var/www/html/phpinfo.php

WORKDIR /var/www/html

VOLUME /var/www/html
EXPOSE 80
