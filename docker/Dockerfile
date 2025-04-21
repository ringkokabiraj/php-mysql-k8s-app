FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    nginx \
    default-mysql-client \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo pdo_mysql zip

COPY html/ /var/www/html
COPY docker/default.conf /etc/nginx/conf.d/default.conf

CMD service nginx start && php-fpm