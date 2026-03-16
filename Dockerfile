# Use official PHP image with FPM
FROM php:8.2-fpm

# System deps
RUN apt-get update && apt-get install -y \
    libpq-dev \
    zip unzip

# Enable PDO drivers
RUN docker-php-ext-install pdo pdo_pgsql

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . .

# Install dependencies
RUN composer install --no-dev --optimize-autoloader

# Permissions (optional)
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

EXPOSE 8000
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]