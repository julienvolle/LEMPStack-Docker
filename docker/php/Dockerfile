FROM php:7.4-fpm-alpine

# Set php.ini
RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Install NodeJS
RUN apk update \
    && apk add nodejs \
    && apk add npm

# Install PDO
RUN docker-php-ext-install pdo pdo_mysql

# Install OPcache
RUN docker-php-ext-install opcache

# Install Memcached, APCu & Xdebug
ENV MEMCACHED_DEPS zlib-dev libmemcached-dev cyrus-sasl-dev
RUN apk add --no-cache --update libmemcached-libs zlib
RUN set -xe \
    && apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
    && apk add --no-cache --update --virtual .memcached-deps $MEMCACHED_DEPS \
    && pecl install memcached apcu xdebug \
    && docker-php-ext-enable memcached apcu xdebug \
    && pecl clear-cache \
    && apk del .memcached-deps .phpize-deps

# Custom profile
RUN echo 'alias ll="ls -al"' >> ~/.profile
RUN echo 'export PS1="\u@\h \[\033[32m\]\w\[\033[00m\] $ "' >> ~/.profile
