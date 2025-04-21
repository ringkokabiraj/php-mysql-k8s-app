FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Install base tools
RUN apt-get update && apt-get install -y \
    curl gnupg2 ca-certificates lsb-release apt-transport-https unzip supervisor

# Add PHP repo and install PHP + extensions
RUN apt-get install -y gnupg \
    && curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/php.gpg \
    && echo "deb https://packages.sury.org/php/ bullseye main" > /etc/apt/sources.list.d/php.list \
    && apt-get update

RUN apt-get install -y php8.2 php8.2-fpm php8.2-cli php8.2-common php8.2-mysql php8.2-pgsql \
    php8.2-curl php8.2-mbstring php8.2-xml php8.2-gd php8.2-zip php8.2-soap php8.2-bcmath php8.2-intl php8.2-readline

# Install nginx
RUN apt-get install -y nginx

RUN apt install -y net-tools

RUN apt install -y vim

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy configs
COPY docker/default.conf /etc/nginx/conf.d/default.conf
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY html/index.php /var/www/html/index.php

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Expose ports
EXPOSE 80

CMD ["/usr/bin/supervisord"]