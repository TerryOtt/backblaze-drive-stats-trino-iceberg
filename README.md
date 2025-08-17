* `docker compose up --detach`
* `docker compose logs -f` 
* Wait until you see the line `io.trino.server.Server  ======== SERVER STARTED ========` 
  * Usually 10-15 seconds
* Ctrl-C

## Running Setup

```bash
$ time ./register-drive-stats-table.sh
CREATE SCHEMA
USE
CALL

real    1m10.094s
user    0m0.022s
sys     0m0.029s
```

## Running Queries On Drive Stats Data

```sql
$ ./cli.sh
trino:drivestats_b2.ds_schema> SHOW TABLES;
   Table
------------
 drivestats
(1 row)

Query 20250817_155734_00011_rbemr, FINISHED, 1 node
Splits: 7 total, 7 done (100.00%)
0.18 [1 rows, 29B] [5 rows/s, 164B/s]

trino:ds_schema> SELECT COUNT(DISTINCT serial_number) AS unique_drive_count FROM drivestats;
 unique_drive_count
--------------------
             468220
(1 row)

Query 20250817_160017_00014_rbemr, FINISHED, 1 node
Splits: 417 total, 417 done (100.00%)
25.94 [621M rows, 2.27GiB] [23.9M rows/s, 89.4MiB/s]

trino:ds_schema>
```

## Teardown

```bash
trino:ds_schema> exit
$ docker compose down
$ docker system prune -f --volumes
```
