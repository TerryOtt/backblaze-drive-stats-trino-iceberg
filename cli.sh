#!/usr/bin/bash

DOCKER="/usr/bin/docker"
DOCKER_COMPOSE_SERVICE="trino"
TRINO_CATALOG="drivestats_b2"
TRINO_DRIVESTATS_SCHEMA="ds_schema"

${DOCKER} compose exec -it ${DOCKER_COMPOSE_SERVICE} trino --catalog ${TRINO_CATALOG} --schema ${TRINO_DRIVESTATS_SCHEMA}
