FROM php:8.2-fpm

RUN apt-get update && apt-get install -y nginx \
    default-mysql-client \
    libzip-dev zip unzip \
    && docker-php-ext-install pdo pdo_mysql zip

# Copy site files and nginx config
COPY html/ /var/www/html
COPY docker/default.conf /etc/nginx/conf.d/default.conf

# Expose ports
EXPOSE 80

# Use supervisord to run both nginx and php-fpm
RUN apt-get install -y supervisor
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
