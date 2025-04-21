FROM php:8.2-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    nginx \
	net-tools \
    default-mysql-client \
    libzip-dev zip unzip \
    supervisor \
    && docker-php-ext-install pdo pdo_mysql zip \
    && apt-get clean

# Create required directories
RUN mkdir -p /run/php /var/www/html && chown -R www-data:www-data /var/www/html

# Copy app code and configuration files
COPY html/ /var/www/html/
COPY docker/default.conf /etc/nginx/conf.d/default.conf
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose port 80 for web traffic
EXPOSE 80

# Start supervisord to run both NGINX and PHP-FPM
CMD ["/usr/bin/supervisord"]
