FROM php:8.1-apache

# Install system packages + PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libonig-dev \
    libcurl4-openssl-dev \
    ffmpeg \
    zip \
    unzip \
    && docker-php-ext-configure gd \
        --with-freetype --with-jpeg \
    && docker-php-ext-install \
        mysqli \
        pdo \
        pdo_mysql \
        mbstring \
        curl \
        zip \
        gd

# Enable Apache mods
RUN a2enmod rewrite headers

# Set working directory
WORKDIR /var/www/html

# Copy app files
COPY . /var/www/html

# Fix permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www
