#!/bin/bash

export COMPOSER_ALLOW_SUPERUSER=1

apt-get update \
  && apt-get install -q -y --no-install-recommends \
    vim \
    wget \
    mariadb-client \
    pv \
    git \
    openssh-client

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
ln -s /usr/local/bin/composer /usr/bin/composer

composer global require drush/drush:9.*

ln -s ~/.composer/vendor/bin/drush /usr/local/bin/drush
