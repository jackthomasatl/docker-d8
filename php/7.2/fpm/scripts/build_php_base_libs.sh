#!/bin/bash

if [ -n "$HTTP_PROXY" ]; then
    pear config-set http_proxy "$HTTP_PROXY"
fi

# Possible: bcmath bz2 calendar ctype curl dba dom enchant exif fileinfo filter ftp gd gettext gmp hash iconv imap interbase intl json ldap mbstring mysqli oci8 odbc opcache pcntl pdo pdo_dblib pdo_firebird pdo_mysql pdo_oci pdo_odbc pdo_pgsql pdo_sqlite pgsql phar posix pspell readline recode reflection session shmop simplexml snmp soap sockets spl standard sysvmsg sysvsem sysvshm tidy tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl zip

BASE_PHP_MODULES=('bcmath' 'bz2' 'calendar' 'ctype' 'curl' 'dba' 'dom' 'exif' 'fileinfo' 'ftp' 'gd' 'gettext' 'gmp' 'hash' 'iconv' 'imap' 'json' 'ldap' 'mbstring' 'mysqli' 'opcache' 'pcntl' 'pdo' 'pdo_dblib' 'pdo_mysql' 'pdo_pgsql' 'pdo_sqlite' 'pgsql' 'phar' 'posix' 'pspell' 'readline' 'session' 'shmop' 'simplexml' 'soap' 'sockets' 'sysvmsg' 'sysvsem' 'sysvshm' 'tidy' 'tokenizer' 'wddx' 'xml' 'xmlreader' 'xmlrpc' 'xmlwriter' 'xsl' 'zip')

BZ2_LIBS='libbz2-dev'
CURL_LIBS='curl libcurl3-dev'
FTP_LIBS='libssl-dev'
GD_LIBS='libgd-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev'
GMP_LIBS='libgmp-dev'
IMAGICK_LIBS='libmagickwand-dev'
IMAP_LIBS='libc-client-dev libkrb5-dev'
LDAP_LIBS='libldap2-dev'
POSTGRESS_LIBS='libpq-dev'
PDO_LIBS='libldb-dev freetds-dev libsybdb5'
PSPELL_LIBS='libpspell-dev'
READLINE_LIBS='libreadline-dev libedit-dev'
SSH_LIBS='openssh-client libssh2-1-dev'
SQLITE_LIBS='sqlite3 libsqlite3-dev'
TIDY_LIBS='tidy libtidy-dev'
XML_LIBS='libxml2-dev ' #Soap too
XSL_LIBS='libxslt-dev'
ZIP_LIBS='zip unzip zlib1g-dev'

echo "Installing dependencies: "
apt-get update \
  && apt-get install -q -y --no-install-recommends \
    $BZ2_LIBS \
    $CURL_LIBS \
    $FTP_LIBS \
    $GD_LIBS \
    $GMP_LIBS \
    $IMAGICK_LIBS \
    $IMAP_LIBS \
    $LDAP_LIBS \
    $POSTGRESS_LIBS \
    $PDO_LIBS \
    $PSPELL_LIBS \
    $READLINE_LIBS \
    $SSH_LIBS \
    $SQLITE_LIBS \
    $TIDY_LIBS \
    $XML_LIBS \
    $XSL_LIBS \
    $ZIP_LIBS

for module_name in "${BASE_PHP_MODULES[@]}"; do
  echo -e "\n\n\n\n\n"
  echo "PHP EXT Install: $module_name";

  ## preconditions
  case "$module_name" in

    'gd')
      docker-php-ext-configure "$module_name" \
          --with-gd \
          --with-webp-dir \
          --with-jpeg-dir \
          --with-png-dir \
          --with-zlib-dir \
          --with-xpm-dir \
          --with-freetype-dir \
          --enable-gd-native-ttf
      ;;

    'imap')
      docker-php-ext-configure "$module_name" \
        --with-kerberos \
        --with-imap-ssl
      ;;

    'pdo_dblib')
      ln -s /usr/lib/x86_64-linux-gnu/libsybdb.a /usr/lib/
      ;;

  esac

  ## compile
  case "$module_name" in

    'xmlreader')
      CFLAGS="-I/usr/src/php" \
        docker-php-ext-install -j$(nproc) "$module_name"
      ;;

    *)
      docker-php-ext-install -j$(nproc) "$module_name"
      ;;

  esac

  ## error?
  if [ "$?" -gt 0 ]; then
    echo "Failed to install $module_name"
    exit 1
  fi
done
