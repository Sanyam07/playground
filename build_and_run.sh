#!/usr/bin/env bash

docker pull node:9.2.0
docker-compose pull
docker-compose up -d pgsql

echo ''
echo ''
echo "-------------------------------------BUILDING FRONTEND-------------------------------------"
echo ''
echo ''

set -o xtrace
rm -rf ./static
FRONTEND_BUILDER_CONTAINER=`docker run -d --entrypoint sleep node:9.2.0 infinity`
docker cp ./frontend ${FRONTEND_BUILDER_CONTAINER}:/frontend
docker exec -i -t ${FRONTEND_BUILDER_CONTAINER} sh -c "cd /frontend && npm install && npm run build"
docker cp ${FRONTEND_BUILDER_CONTAINER}:/frontend/build ./static
docker rm -f -v ${FRONTEND_BUILDER_CONTAINER}
set +o xtrace

echo ''
echo ''
echo "--------------------------------------BUILDING SERVICE--------------------------------------"
echo ''
echo ''

docker-compose build


echo ''
echo ''
echo "--------------------------------------RUNNING SERVICE--------------------------------------"
echo ''
echo ''
docker-compose up -d playground
python -mwebbrowser http://localhost:8080