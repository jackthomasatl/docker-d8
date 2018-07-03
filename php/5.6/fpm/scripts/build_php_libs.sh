#!/bin/bash

if [ -n "$HTTP_PROXY" ]; then
    pear config-set http_proxy "$HTTP_PROXY"
fi

apt-get update && apt-get install -y --no-install-recommends \
  libbz2-dev \
  libcurl3-dev \
  libgmp-dev \
  libldap2-dev \
  libldb-dev \
  libmcrypt-dev \
  libsqlite3-dev \
  libssl-dev \
  libtidy-dev \
  libxml2-dev \
  sqlite3 \
  zlib1g-dev \
  libxslt1-dev

rm \
  /usr/include/gmp.h \
  /usr/lib/libldap.so \
  /usr/lib/liblber.so 2> /dev/null

ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
  && ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
  && ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so

docker-php-ext-install \
  bcmath bz2 calendar ctype curl dom exif fileinfo ftp \
  gettext gmp hash iconv json ldap mbstring mcrypt mysql mysqli \
  opcache pdo pdo_mysql pdo_sqlite session shmop soap sockets \
  tidy tokenizer wddx xsl xml xmlreader zip

# gd
apt-get install -y --no-install-recommends \
  libgd-dev \
  libfreetype6-dev \
  libjpeg-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  libwebp-dev \
  libxpm-dev \
  libmagickwand-dev

docker-php-ext-configure gd \
  --with-gd \
  --with-webp-dir \
  --with-jpeg-dir \
  --with-png-dir \
  --with-zlib-dir \
  --with-xpm-dir \
  --with-freetype-dir \
  --enable-gd-native-ttf && \
  docker-php-ext-install gd

# apcu
pecl install -o -f apcu-4.0.11 \
  && docker-php-ext-enable apcu

# apm (ignored)

# imagick
apt-get install -y --no-install-recommends \
  libmagickwand-dev
pecl install -o -f imagick \
  && docker-php-ext-enable imagick

# imap (ignored)

# memcached
apt-get install -y --no-install-recommends \
  libmemcached-dev

pecl install -o -f memcached-2.2.0 \
  && docker-php-ext-enable memcached

# OAuth
pecl install -o -f oauth-1.2.3 \
  && docker-php-ext-enable oauth

# odbc (ignored)

# posix (ignored, not on prod)

# readline (ignored, not on prod)

# redis
pecl install -o -f redis \
  && docker-php-ext-enable redis

# xdebug
pecl install -o -f xdebug-2.5.5 \
 && docker-php-ext-enable xdebug

# cleanup
rm -rf /var/lib/apt/lists/* /tmp/pear
