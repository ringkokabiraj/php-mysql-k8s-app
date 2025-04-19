FROM php:8.2-fpm

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    nginx \
    supervisor \
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
RUN apt-get install -y libicu-dev && docker-php-ext-install intl
RUN docker-php-ext-install opcacheRUN apt-get install -y libicu-dev && docker-php-ext-install intl
RUN docker-php-ext-install opcache
# Copy app source
COPY src/ /var/www/html/
RUN chown -R www-data:www-data /var/www/html

# Copy nginx config
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose HTTP port
EXPOSE 80

# Start Supervisor (which runs PHP-FPM and Nginx)
CMD ["/usr/bin/supervisord"]
