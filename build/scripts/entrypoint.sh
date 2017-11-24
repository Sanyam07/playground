#!/bin/bash
#$1 - what to start
#$2 - env, just for information

set -o errexit
set -o xtrace
set -o pipefail

export DJANGO_SETTINGS_MODULE=playground.settings

echo "/opt/playground/playground" > /usr/local/lib/python3.6/site-packages/playground.pth
echo Migrate database schema
python /opt/playground/manage.py migrate

echo Starting service
exec /usr/bin/supervisord -c /opt/playground/configs/supervisor.conf.ini
