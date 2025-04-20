# Base PHP image
FROM php:8.2-fpm

# Install system packages and PHP extensions
RUN apt-get update && apt-get install -y \
    nginx \
    curl \
    zip unzip \
    git \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libmcrypt-dev \
    libicu-dev \
    libxslt1-dev \
    libssl-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        gd \
        mysqli \
        pdo \
        pdo_mysql \
        zip \
        mbstring \
        xml \
        opcache \
        intl \
        xsl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
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
