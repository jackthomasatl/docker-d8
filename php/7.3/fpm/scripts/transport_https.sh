#!/bin/bash

echo 'deb http://cloudfront.debian.net/debian/ stretch main' > /etc/apt/sources.list

apt-get update &&
  apt-get install -y --no-install-recommends apt-transport-https apt-utils
