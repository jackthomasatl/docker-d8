#!/bin/bash

export COMPOSER_ALLOW_SUPERUSER=1

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
ln -s /usr/local/bin/composer /usr/bin/composer

composer global require drush/drush:8.*

ln -s ~/.composer/vendor/bin/drush /usr/local/bin/drush
