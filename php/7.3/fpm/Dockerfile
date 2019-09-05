# jackthomasatl/docker-d8:7.3.8-fpm

FROM jackthomasatl/docker-php:7.3.8-fpm-dev

COPY ./scripts/* /opt/docker/scripts/
COPY ./docker/php/drushrc.php /root/.drush/drushrc.php

# Drush
RUN /bin/bash /opt/docker/scripts/install_drush.sh
