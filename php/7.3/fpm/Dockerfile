# jackthomasatl/docker-php:7.3.8-fpm

FROM php:7.3.8-fpm-buster

ENV DEBIAN_FRONTEND=noninteractive PHP=7.1 USER=www-data
ENV COMPOSER_ALLOW_SUPERUSER=1

RUN mkdir -p /opt/docker/
COPY ./scripts /opt/docker/scripts

# Apt Sources
# RUN /bin/bash /opt/docker/scripts/transport_https.sh
COPY ./apt/sources.list /etc/apt/sources.list

# Php Modules
RUN /bin/bash /opt/docker/scripts/build_php_base_libs.sh
RUN /bin/bash /opt/docker/scripts/build_php_pecl_libs.sh

# Install Utils
COPY ./tools /opt/docker/tools
ENV PATH="/opt/docker/tools:${PATH}"
RUN /bin/bash /opt/docker/scripts/install_utils.sh

# Move configs in
COPY ./config/php.ini /usr/local/etc/php/php.ini
COPY ./config/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./config/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Move php sample app
RUN mkdir -p /app/docroot
COPY ./phpinfo /app/docroot
RUN ln -s /app/docroot /opt/docroot

WORKDIR /app
