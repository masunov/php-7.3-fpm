FROM php:7.3-fpm

RUN apt-get update && apt-get install -qy git curl wget zip zlib1g-dev libzip-dev libcurl4-openssl-dev libssl-dev libmcrypt-dev libfreetype6-dev libjpeg62-turbo-dev libpq-dev libpng-dev && docker-php-ext-install -j$(nproc) iconv && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install -j$(nproc) gd && docker-php-ext-install pdo_mysql pdo_pgsql && docker-php-ext-configure zip --with-libzip && docker-php-ext-install zip && wget https://getcomposer.org/installer && php installer --install-dir=/usr/local/bin --filename=composer \
    && pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis
EXPOSE 9000

CMD ["php-fpm"]