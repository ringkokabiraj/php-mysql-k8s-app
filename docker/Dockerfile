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

# Create a basic www.conf for PHP-FPM if it doesn't exist
RUN echo "[www]" > /etc/php/8.2/fpm/pool.d/www.conf && \
    echo "user = www-data" >> /etc/php/8.2/fpm/pool.d/www.conf && \
    echo "group = www-data" >> /etc/php/8.2/fpm/pool.d/www.conf && \
    echo "listen = 127.0.0.1:9000" >> /etc/php/8.2/fpm/pool.d/www.conf && \
    echo "listen.mode = 0666" >> /etc/php/8.2/fpm/pool.d/www.conf && \
    echo "pm = dynamic" >> /etc/php/8.2/fpm/pool.d/www.conf && \
    echo "pm.max_children = 50" >> /etc/php/8.2/fpm/pool.d/www.conf && \
    echo "pm.start_servers = 5" >> /etc/php/8.2/fpm/pool.d/www.conf && \
    echo "pm.min_spare_servers = 5" >> /etc/php/8.2/fpm/pool.d/www.conf && \
    echo "pm.max_spare_servers = 35" >> /etc/php/8.2/fpm/pool.d/www.conf && \
    echo "chdir = /" >> /etc/php/8.2/fpm/pool.d/www.conf

# Expose necessary ports
EXPOSE 80

# Use supervisor to run both NGINX and PHP-FPM
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
