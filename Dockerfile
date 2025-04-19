FROM php:8.2-fpm

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    nginx \
    curl \
    zip \
    unzip \
    git \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-install pdo pdo_mysql zip mbstring exif pcntl bcmath gd

# Copy app source
COPY src/ /var/www/html/

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html

# Copy Nginx config
COPY default.conf /etc/nginx/conf.d/default.conf

# Expose ports
EXPOSE 80

# Start both PHP-FPM and Nginx
CMD service php8.2-fpm start && nginx -g 'daemon off;'