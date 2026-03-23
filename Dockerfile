FROM php:8.4-fpm

# System deps + Chromium untuk Puppeteer
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpq-dev \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    libonig-dev \
    chromium \
    fonts-liberation \
    fonts-noto-color-emoji \
    && rm -rf /var/lib/apt/lists/*

# PHP extensions
RUN docker-php-ext-install \
    pdo_pgsql \
    bcmath \
    mbstring \
    xml \
    zip \
    gd \
    pcntl \
    sockets

# phpredis
RUN pecl install redis && docker-php-ext-enable redis

# Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/app2

COPY . .

RUN composer install --optimize-autoloader --no-dev

RUN npm ci && npm run build

# Chromium untuk Puppeteer
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

RUN chown -R www-data:www-data /var/www/app2/storage /var/www/app2/bootstrap/cache

EXPOSE 9000

CMD ["php-fpm"]