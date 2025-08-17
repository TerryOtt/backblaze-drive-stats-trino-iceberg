#!/usr/bin/bash

DOCKER="/usr/bin/docker"
DOCKER_COMPOSE_SERVICE="trino"
TRINO_CATALOG="drivestats_b2"

${DOCKER} compose exec -it ${DOCKER_COMPOSE_SERVICE} trino --catalog ${TRINO_CATALOG} --execute "CREATE SCHEMA drivestats_b2.ds_schema WITH (location = 's3://drivestats-iceberg/');"

${DOCKER} compose exec -it ${DOCKER_COMPOSE_SERVICE} trino --catalog ${TRINO_CATALOG} --execute "USE drivestats_b2.ds_schema;"

${DOCKER} compose exec -it ${DOCKER_COMPOSE_SERVICE} trino --catalog ${TRINO_CATALOG} --execute "CALL drivestats_b2.system.register_table(schema_name => 'ds_schema', table_name => 'drivestats', table_location => 's3://drivestats-iceberg/drivestats' );"
