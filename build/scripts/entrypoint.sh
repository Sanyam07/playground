#!/bin/bash
#$1 - what to start
#$2 - env, just for information

set -o errexit
set -o xtrace
set -o pipefail

export DJANGO_SETTINGS_MODULE=playground.settings
export DATABASE_HOST=${DB_HOST}

export PURPOSE=$1
export ENV=$2

export DATABASE_USER=postgres
export DATABASE_PASSWORD=postgres

if [[ "$PURPOSE" == "service" ]]; then
    echo Starting service
    exec /usr/bin/supervisord -c /opt/playground/configs/supervisor.conf.ini
elif [[ "$PURPOSE" == "migration" ]]; then
    echo Migrations database schema
    django-admin migrate
fi
