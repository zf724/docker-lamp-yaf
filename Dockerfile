FROM php:5-apache
MAINTAINER PHP Docker Maintainers
#php default config
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
    && docker-php-source extract \
    && docker-php-ext-install -j$(nproc) mysql mysqli pdo_mysql iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-source delete

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN set -xe \
    && mv /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

COPY example-www/web01/l.php /var/www/html/l.php
COPY example-www/web02/phpinfo.php /var/www/html/phpinfo.php

#php yaf_demo config
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

COPY yaf_config/web.conf /etc/apache2/sites-enabled/web.conf
COPY yaf_config/docker-php-ext-yaf.ini /usr/local/etc/php/conf.d/docker-php-ext-yaf.ini

WORKDIR /var/www/html

VOLUME /var/www/html
EXPOSE 80
