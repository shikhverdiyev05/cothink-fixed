# =============================================================================
# Stage 1: Build the React frontend
# =============================================================================
FROM node:18-alpine AS frontend-builder

WORKDIR /app/client

# Copy package files and install dependencies
COPY client/package.json client/package-lock.json ./
RUN npm ci

# Copy the rest of the client source and build
COPY client/ ./
RUN npm run build
# Output: /app/client/dist

# =============================================================================
# Stage 2: PHP + Apache production image
# =============================================================================
FROM php:8.2-apache

# Install system dependencies and PHP extensions needed by the app
RUN apt-get update && apt-get install -y \
        unzip \
        libzip-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql zip gd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set the document root to serve the React build as the site root
ENV APACHE_DOCUMENT_ROOT /var/www/html

WORKDIR /var/www/html

# Copy PHP backend into /var/www/html/server/ so that API calls to
# /server/... resolve correctly (matches the apiUrl pattern in the frontend)
COPY server/ ./server/

# Install PHP dependencies (composer.json lives at the repo root,
# vendor/ is referenced as ../../../vendor from server/settings/)
COPY composer.json ./
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Copy the built React app to the document root so it is served as the SPA
COPY --from=frontend-builder /app/client/dist/ ./

# Ensure the uploads directory exists and is writable by Apache
RUN mkdir -p ./server/uploads \
    && chown -R www-data:www-data ./server/uploads \
    && chmod -R 775 ./server/uploads

# Enable Apache modules required for SPA routing and CORS
RUN a2enmod rewrite headers

# Apache virtual host configuration:
#   - Serves the React SPA from the document root
#   - Falls back to index.html for client-side routes (React Router)
#   - PHP files under /server/ are handled by mod_php as normal
RUN { \
    echo '<VirtualHost *:80>'; \
    echo '    DocumentRoot /var/www/html'; \
    echo '    DirectoryIndex index.html index.php'; \
    echo ''; \
    echo '    # Allow .htaccess overrides'; \
    echo '    <Directory /var/www/html>'; \
    echo '        Options -Indexes +FollowSymLinks'; \
    echo '        AllowOverride All'; \
    echo '        Require all granted'; \
    echo '    </Directory>'; \
    echo ''; \
    echo '    # PHP backend — served directly, no SPA fallback'; \
    echo '    <Directory /var/www/html/server>'; \
    echo '        Options -Indexes +FollowSymLinks'; \
    echo '        AllowOverride All'; \
    echo '        Require all granted'; \
    echo '    </Directory>'; \
    echo ''; \
    echo '    # SPA fallback: any request that is not a real file or'; \
    echo '    # directory and does not start with /server/ is served'; \
    echo '    # as index.html so React Router can handle it'; \
    echo '    RewriteEngine On'; \
    echo '    RewriteCond %{REQUEST_URI} !^/server/'; \
    echo '    RewriteCond %{REQUEST_FILENAME} !-f'; \
    echo '    RewriteCond %{REQUEST_FILENAME} !-d'; \
    echo '    RewriteRule ^ /index.html [L]'; \
    echo ''; \
    echo '    ErrorLog ${APACHE_LOG_DIR}/error.log'; \
    echo '    CustomLog ${APACHE_LOG_DIR}/access.log combined'; \
    echo '</VirtualHost>'; \
} > /etc/apache2/sites-available/000-default.conf

EXPOSE 80

CMD ["apache2-foreground"]
