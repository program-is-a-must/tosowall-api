#!/usr/bin/env bash

echo "Running composer..."
cd /var/www/html && composer install --no-dev --optimize-autoloader

echo "Clearing old config..."
php artisan config:clear

echo "Creating SQLite database..."
mkdir -p /var/www/html/database
touch /var/www/html/database/database.sqlite
chmod 775 /var/www/html/database/database.sqlite

echo "Caching config..."
php artisan config:cache

echo "Caching routes..."
php artisan route:cache

echo "Running migrations..."
php artisan migrate --force