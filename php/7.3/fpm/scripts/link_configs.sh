#!/bin/bash

if [ -n "$HTTP_PROXY" ]; then
    pear config-set http_proxy "$HTTP_PROXY"
fi

rm /usr/local/etc/php/php.ini 2> /dev/null
ln -s /opt/docker/php/php.ini /usr/local/etc/php/php.ini

rm /usr/local/etc/php/conf.d/xdebug.ini 2> /dev/null
ln -s /opt/docker/php/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
