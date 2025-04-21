# Use the official PHP-FPM image as a base
FROM php:8.2-fpm

# Install necessary packages (e.g., nginx, supervisor, etc.)
RUN apt-get update && apt-get install -y nginx \
    default-mysql-client \
    libzip-dev zip unzip supervisor \
    && docker-php-ext-install pdo pdo_mysql zip

# Copy site files and NGINX config
COPY html/ /var/www/html
COPY docker/default.conf /etc/nginx/conf.d/default.conf

COPY docker/www.conf /usr/local/etc/php-fpm.d/www.conf

# Expose necessary ports
EXPOSE 80

# Use supervisor to run both NGINX and PHP-FPM
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
