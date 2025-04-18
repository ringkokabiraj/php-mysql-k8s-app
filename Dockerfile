# Dockerfile
FROM php:7.4-apache

# Install MySQL PDO extension
RUN docker-php-ext-install pdo pdo_mysql

# Copy application files
COPY . /var/www/html/

EXPOSE 80