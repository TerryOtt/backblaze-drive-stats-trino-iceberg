# backblaze-drive-stats-trino-iceberg

## Credit Where It's Due

* Backblaze [publishing their drive stats](https://www.backblaze.com/cloud-storage/resources/hard-drive-test-data) for the world to play with is awesome
* Backblaze [publishing their drive stats](https://www.backblaze.com/blog/iceberg-on-backblaze-b2/) in [Apache Iceberg](https://iceberg.apache.org/) table format on Backblaze B2 so we don't all need to pull the CSV down and ETL it into our favorite OLAP database is also awesome
* Pat Patterson's GitHub repo for [integrating Trino with Iceberg tables hosted on Backblaze B2](https://github.com/backblaze-b2-samples/trino-getting-started-b2/tree/main/iceberg/trino-iceberg-hive-b2) was _exceptionally_ helpful
  * Pat is a (the?) Chief Technical Evangelist at Backblaze

## Launch Docker Containers
* `docker compose up --detach`
* `docker compose logs -f` 
* Wait until you see the line `io.trino.server.Server  ======== SERVER STARTED ========` 
  * Usually 10-15 seconds
* Ctrl-C

## Register the Backblaze Drive Stats Table With Trino Server

```sql
$ time ./register-drive-stats-table.sh
CREATE SCHEMA
USE
CALL

real    1m10.094s
user    0m0.022s
sys     0m0.029s

$ ./cli.sh
trino:drivestats_b2.ds_schema> SHOW TABLES;
   Table
------------
 drivestats
(1 row)

Query 20250817_155734_00011_rbemr, FINISHED, 1 node
Splits: 7 total, 7 done (100.00%)
0.18 [1 rows, 29B] [5 rows/s, 164B/s]

trino:drivestats_b2.ds_schema> exit
$
```

## Running Trino Queries On Drive Stats Data

```sql
$ ./cli.sh
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

## Cleanup

```bash
trino:ds_schema> exit
$ docker compose down
$ docker system prune -f --volumes
$ docker rmi apache/hive:4.1.0
$ docker rmi trinodb/trino:latest
```
