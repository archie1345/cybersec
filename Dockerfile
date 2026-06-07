FROM composer:2 AS vendor

WORKDIR /app

COPY composer.json composer.lock ./
RUN composer install \
    --no-dev \
    --no-interaction \
    --no-progress \
    --no-scripts \
    --prefer-dist \
    --optimize-autoloader

COPY . .
RUN composer dump-autoload --optimize

FROM node:24-alpine AS assets

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY vite.config.js ./
COPY resources ./resources
COPY public ./public
RUN npm run build

FROM php:8.4-cli-alpine AS php-runtime

WORKDIR /var/www/html

RUN apk add --no-cache icu-libs oniguruma sqlite-libs \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS icu-dev oniguruma-dev sqlite-dev \
    && docker-php-ext-install intl mbstring pdo_mysql pdo_sqlite \
    && apk del .build-deps

FROM php-runtime AS dev

RUN apk add --no-cache git unzip \
    && addgroup -g 1000 -S laravel \
    && adduser -u 1000 -S laravel -G laravel \
    && chown -R laravel:laravel /var/www/html

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

EXPOSE 8000

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]

FROM php-runtime AS production

COPY --from=vendor /app /var/www/html
COPY --from=assets /app/public/build /var/www/html/public/build

RUN addgroup -g 1000 -S laravel \
    && adduser -u 1000 -S laravel -G laravel \
    && mkdir -p storage/framework/cache/data storage/framework/sessions storage/framework/views storage/logs bootstrap/cache \
    && chown -R laravel:laravel storage bootstrap/cache

USER laravel

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD php -r "exit(@file_get_contents('http://127.0.0.1:8000/up') === false ? 1 : 0);"

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
