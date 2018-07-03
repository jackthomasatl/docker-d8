# jackthomasatl/docker-d7-php:5.6.36-fpm

FROM php:5.6.36-fpm

ENV DEBIAN_FRONTEND=noninteractive PHP=5.6 USER=www-data
ENV COMPOSER_ALLOW_SUPERUSER=1

RUN mkdir -p /opt/docker/
COPY ./scripts /opt/docker/scripts

# Apt Sources
RUN /bin/bash /opt/docker/scripts/transport_https.sh
COPY ./apt/sources.list /etc/apt/sources.list

# Php Modules
RUN /bin/bash /opt/docker/scripts/build_php_libs.sh

# Install Utils
RUN /bin/bash /opt/docker/scripts/install_utils.sh
RUN /bin/bash /opt/docker/scripts/install_drush.sh
COPY ./tools/* /usr/local/bin/

# Move configs in
COPY ./config/php.ini /usr/local/etc/php/php.ini
COPY ./config/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Move php sample app
COPY ./phpinfo /app
RUN ln -s /app /opt/docroot

WORKDIR /app
