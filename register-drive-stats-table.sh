#!/usr/bin/bash

DOCKER="/usr/bin/docker"

${DOCKER} exec -it trino_experimentation-trino-1 trino --catalog drivestats_b2 --execute "CREATE SCHEMA drivestats_b2.ds_schema WITH (location = 's3://drivestats-iceberg/');"

${DOCKER} exec -it trino_experimentation-trino-1 trino --catalog drivestats_b2 --execute "USE drivestats_b2.ds_schema;"

${DOCKER} exec -it trino_experimentation-trino-1 trino --catalog drivestats_b2 --execute "CALL drivestats_b2.system.register_table(schema_name => 'ds_schema', table_name => 'drivestats', table_location => 's3://drivestats-iceberg/drivestats' );"
