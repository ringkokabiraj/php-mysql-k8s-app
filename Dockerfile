FROM php:7.4-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    libicu-dev \
    git \
    zip \
    libonig-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        pdo \
        pdo_mysql \
        mysqli \
        gd \
        zip \
        intl \
        opcache

# Enable Apache mod_rewrite if needed
RUN a2enmod rewrite

# Copy application files
COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html
# Expose port 80
EXPOSE 80