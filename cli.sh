#!/usr/bin/bash

DOCKER="/usr/bin/docker"

${DOCKER} exec -it trino_experimentation-trino-1 trino --catalog drivestats_b2 --schema ds_schema;
