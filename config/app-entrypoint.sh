#!/bin/bash -e

. /opt/bitnami/base/functions
. /opt/bitnami/base/helpers

print_welcome_page

if [[ "$1" == "nami" && "$2" == "start" ]] || [[ "$1" == "httpd" ]]; then
  . /init.sh
  nami_initialize apache php mysql-client libphp matomo
  info "Initializing custom GCtools config / plugins......"
  php ./opt/bitnami/matomo/console plugin:activate GCToolsTheme
  chmod -R 777 /opt/bitnami/matomo/tmp
  info "Starting matomo... "
fi

exec tini -- "$@"