#!/bin/bash

set -e

ln -s /etc/supervisor/supervisord.conf /etc/supervisord.conf

if [ -z "$@" ]; then
  exec /usr/local/bin/supervisord -c /etc/supervisord.conf --nodaemon
else
  echo "Ok"
fi