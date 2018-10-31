#!/bin/bash

apt-get update \
  && apt-get install -q -y --no-install-recommends \
    vim \
    wget \
    mariadb-client \
    pv \
    git \
    openssh-client
