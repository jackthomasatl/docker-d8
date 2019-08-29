#!/bin/bash

if [ -n "$HTTP_PROXY" ]; then
    pear config-set http_proxy "$HTTP_PROXY"
fi

PECL_PHP_MODULES=('apcu' 'gnupg' 'raphf' 'propro' 'http' 'igbinary' 'imagick' 'memcached' 'oauth' 'ssh2' 'xdebug' 'yaml')

# newrelic (ignored), tideways (ignored)

GNUPG_LIBS='libgpgme11-dev'
IMAGICK_LIBS='libmagickwand-dev' #
MEMCACHED_LIBS='libmemcached-dev'
SSH_LIBS='openssh-client libssh2-1-dev'
YAML_LIBS='libyaml-dev'

echo "Installing dependencies: "
apt-get update \
  && apt-get install -q -y --no-install-recommends \
    $GNUPG_LIBS \
    $IMAGICK_LIBS \
    $MEMCACHED_LIBS \
    $SSH_LIBS \
    $YAML_LIBS

for module_name in "${PECL_PHP_MODULES[@]}"; do
  echo -e "\n\n\n\n\n"
  echo "PECL EXT Install: $module_name";

  pecl_module_name="$module_name"

  case "$module_name" in

    'ssh2')
      pecl_module_name="ssh2-1.0"
      ;;

    'http')
      pecl_module_name="pecl_http"
      ;;

  esac

  pecl -v install "$pecl_module_name" \
    && docker-php-ext-enable "$module_name"

  ## error?
  if [ "$?" -gt 0 ]; then
    echo "Failed to install $module_name"
    exit 1
  fi
done
