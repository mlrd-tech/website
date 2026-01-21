---
---

# Metrics

mlrd reports OpenTelemetry gauges and counters.
Most metrics are table counters with a `table_name` tag.
Metrics without a `table_name` tag are system metrics.

## Counters

Counters are cumulative.
For example, with a 5 second reporting frequency, a counter at 50 that increases by 20 every interval reports:

|Interval  |Counter Value|
|----------|-------------|
| [0,   5) | 50          |
| [5,  10) | 70          |
| [10, 15) | 90          |

Cumulative counters are standard for Prometheus and Grafana, but other platforms (like Datadog) expect counters to be deltas.

## Gauges

Gauges are reported as `G_max` and `G_pN` where:

* `G` is the gauge name, like `response_time`
* `_max` is the maximum value observed during the report interval
* `_pN` is one of the configured percentiles, like `G_p99` for the 99th percentile

When graphing max and percentiles, use a max rollup.
(Do not average percentiles.)

The default percentiles are 50th (median) and 99th.

There is no average value because averages are a common metric anti-pattern.

Time values are milliseconds and whole number (no fractional time values).

## Metric Naming Schema and Prefixes

Metric names are lowercase and snake case, like `req_table`.

|Prefix       |Meaning                  |
|-------------|-------------------------|
|`backfill_`  |Backfill (migration)     |
|`ddb_`       |Call to AWS DDB          |
|`err_`       |Error                    |
|`legacy_`    |Legacy parameters        |
|`projection_`|Projection expression    |
|`readfill_`  |Readfill (migration)     |
|`req_`       |Client request           |
|`sql_`       |Call to SQL store (MySQL)|
|`t_`         |Time (milliseconds)      |

All metric names are globally unique.

To keep metric names short, counter metrics are logically grouped into hierarchies.
(Gauge metrics are grouped but not hierarchical.)
As a result, the prefix is often dropped for lower (more specific) metrics.

## Counter Groups

Counter increments cascade down a hierarchy.
A top-level metric is called a "rollup metric" because it adds (rolls) up lower values.
For example:

```
req
    req_table
        req_write
            req_delete
                req_delete_cond
                    req_delete_cond_fail
```

Every request increments the `req`.
If the request is a table request, it _also_ increments `req_table`.
If the table request is a write, it _also_ increments `req_write`.
If the write is _also_ a delete (`DeleteItem`), it _also_ increments `req_delete`.
If the delete is conditional (`ConditionExpression` is set), it _also_ increments `req_delete_cond`.
And if the condition fails (does not pass), it _also_ increments `req_delete_cond_fail`.

Therefore: `req > req_table > req_write > req_delete > req_delete_cond > req_delete_cond_fail`.
This makes it easy to graph, for example, the percentage of conditional deletes that fail: `req_delete_cond_fail / req_delete_cond * 100`.

There are 5 counter groups:

* Client Request (`req_`)
* DDB Request (`ddb_`)
* SQL store access (`sql_`)
* Migration (`backfill_` and `readfill_`)
* Error (`err_`, `fault`, and `panic`)

Most metrics are table counters, but `*` denotes system counters (no `table_name` tag).

### Client Request

Client request metrics show what clients are requesting.
Normally, these metrics would also reflect server activity (for example, a client requests a read and the server does a read), but mlrd is a three-part system: API (mlrd), DDB, and a SQL store.
Especially during a migration, a single client request can result in multiple server-side requests.
Therefore, client request metrics are only a starting point for monitoring mlrd.

```
req*
    req_fwd*
    req_ctrl*
    req_table
        req_read
            req_get_batch
            req_get_trx
            req_get_one
                req_get_one_nop
            req_query
                req_query_index
                req_query_page
            req_scan
                req_scan_index
                req_scan_page
            check_write_cond
        req_write
            req_write_batch
            req_write_trx
            req_put
                req_put_cond 
                    req_put_cond_fail
            req_delete
                req_delete_cond
                    req_delete_cond_fail
            req_update
                req_update_cond
                    req_update_cond_fail
        legacy_expr_cond
        legacy_expr_filter
        legacy_expr_key
        legacy_expr_projection
        legacy_expr_update
        projection_no_attribute
        projection_not_a_list
        projection_list_index_oob
```

### DDB Request

DDB request metrics track calls from mlrd to AWS on behalf of clients.
Although AWS provides metrics for DDB, mlrd metrics are higher resolution (5s by default).
These metrics are also important during a migration to monitor the additional DDB request necessary to backfill items into SQL.

```
ddb_get_item
ddb_put_item
ddb_update_item
ddb_delete_item
ddb_batch_get_item
ddb_batch_write_item
ddb_query
ddb_scan
ddb_ctrl
ddb_fwd
```

### SQL Store Access

SQL store access metrics show data access to MySQL.
Although MySQL can (and should) be monitored separately, these metrics show access from the client side (mlrd is a client to MySQL).
During a migration it's important to monitor SQL read/write access with respect to DDB read/write access: the former (SQL) eventually takes over for the latter (DDB).

```
sql_read
    sql_read_row
        sql_read_row_nop
    sql_read_set
    sql_scan
        sql_scan_index
        sql_scan_filter
        sql_scan_key_cond
        sql_scan_page
        sql_scan_count
        sql_scan_nop
sql_write
    sql_read_snapshot
    sql_read_cond
    sql_insert
    sql_update
        sql_upsert
    sql_delete
        sql_delete_nop
```

### Migration 

Migration metrics show backfill and readfill work.

```
backfill_write
    backfill_rows_written
readfill_read
    readfill_rows_missing
    readfill_write
        readfill_rows_written
```

### Error

Error metrics count every error mlrd can return.
The top-most (system) counter, `err`, should be monitored to establish a baseline (normal) error rate.
(Production systems usually have a non-zero error rate due unavoidable events like client discounts, network blips, and so on.)

`panic` is in the error group but does not have an `err_` prefix because it's more of a bug (in mlrd) than an error.
`fault` is a serious, nonrecoverable (but caught) failure that means the SQL store data is invalid.

```
err*
    err_http_read*
    err_http_write*
    err_decode_input*
    err_encode_output*
    err_unknown_table*
    err_table
        err_ddb
        err_sql
        err_trx
        err_backfill
        err_readfill
        err_encode_row
        err_decode_row
        err_metrics
    err_client
        err_unknown_index
        err_no_key_value
        err_expr_cond
        err_expr_filer
        err_expr_key
        err_expr_projection
        err_expr_update
panic*
fault*
```

## Gauge Groups

Gauges are also grouped but not hierarchical.
There are 2 gauge groups:

* Response Time
* System

### Response Time

Response time gauges report how long requests and data access took (in milliseconds).
Since these are server-side measurements (inside mlrd), clients will observer _higher_ response times due to network latency that mlrd cannot measure.

```
t_req*
t_req_table_read
t_req_table_write
t_req_batch_read*
t_req_batch_write*
t_sql_read_row
t_sql_read_set
t_sql_scan
t_sql_insert
t_sql_update
t_sql_delete
t_ddb_read
t_ddb_write
```

### System

Currently, there is only 1 system gauge group that measures system load (active requests).

```
load*
```

### Batch Sizes

```
size_get_batch_items
size_write_batch_items
```

## Metric Reference

Type: C=counter; G=gauge
System ✓: system metric; no `table_name` tag

<div style="font-size:0.8em">

|Name       |Type  |System|Description |
|-----------|------|------|------------|
|`backfill_write`            |C| |Number of SQL writes for backfilling data.|
|`backfill_rows_written`     |C| |Number of rows backfilled into SQL on write.|
|`check_write_cond`          |C| |Number of reads for a `ConditionCheck` in a `TransactWriteItems` request.|
|`ddb_batch_get_item`        |C| |Number of BatchGetItem calls to DDB.|
|`ddb_batch_write_item`      |C| |Number of BatchWriteItem calls to DDB.|
|`ddb_ctrl`                  |C| |Number of control plan calls to DDB in addition to `req_ctrl`.|
|`ddb_delete_item`           |C| |Number of DeleteItem calls to DDB.|
|`ddb_fwd`                   |C| |Number of requests forwarded to DDB (transparent proxy).|
|`ddb_get_item`              |C| |Number of GetItem calls to DDB.|
|`ddb_put_item`              |C| |Number of PutItem calls to DDB.|
|`ddb_query`                 |C| |Number of Query calls to DDB.|
|`ddb_scan`                  |C| |Number of Scan calls to DDB.|
|`ddb_update_item`           |C| |Number of UpdateItem calls to DDB.|
|`err`                       |C|✓|Number of _all_ errors.|
|`err_backfill`              |C| |Number of errors backfilling SQL on write.|
|`err_client`                |C| |Number of client errors: invalid syntax, missing values, etc. Monitor this rollup metric per-table.|
|`err_ddb`                   |C| |Number of errors returned by AWS/DDB, returned verbatim to client.|
|`err_decode_input`          |C|✓|Number of errors decoding (unmarshalling) JSON input.|
|`err_decode_row`            |C| |Number of errors decoding (unmarshalling) JSON from SQL.|
|`err_encode_output`         |C|✓|Number of errors encoding (marshalling) JSON output.|
|`err_encode_row`            |C| |Number of errors encoding (marshaling) JSON for SQL.|
|`err_expr_cond`             |C| |Number of conditional expression syntax errors.|
|`err_expr_filer`            |C| |Number of filter expression syntax errors.|
|`err_expr_key`              |C| |Number of key condition syntax errors.|
|`err_expr_projection`       |C| |Number of projection expression syntax errors.|
|`err_expr_update`           |C| |Number of update expression syntax errors.|
|`err_http_read`             |C|✓|Number of HTTP read errors.|
|`err_http_write`            |C|✓|Number of HTTP write errors.|
|`err_metrics`               |C| |Number of errors sending (reporting) metrics.|
|`err_no_key_value`          |C| |Number of requests that do not specify one or more required key value.|
|`err_readfill`              |C| |Number of errors backfilling SQL on read. Reported in log as warnings.|
|`err_sql`                   |C| |Number of errors returned by SQL.|
|`err_table`                 |C|✓|Number of table access errors. Monitor this rollup metric for each table.|
|`err_trx`                   |C| |Number of errors on SQL `BEGIN`, `COMMIT`, or `ROLLBACK`.|
|`err_unknown_index`         |C| |Number of requests that specify an unknown secondary index.|
|`err_unknown_table`         |C|✓|Number of requests that specify an unknown table.|
|`fault`                     |C|✓|Number of serious runtime failures. This value should always be zero.|
|`legacy_expr_cond`          |C| |Number of requests that use legacy parameters instead of `ConditionExpression`.|
|`legacy_expr_filter`        |C| |Number of requests that use legacy parameters instead of `FilterExpression`.|
|`legacy_expr_key`           |C| |Number of `Query` requests that use legacy parameters instead of `KeyConditionExpression`.|
|`legacy_expr_projection`    |C| |Number of read requests that use legacy parameters instead of `ProjectionExpression`.|
|`legacy_expr_update`        |C| |Number of update requests that use legacy parameters instead of `UpdateExpression`.|
|`load`                      |G|✓|Number of active requests. Incremented by 1 when a request begins and decremented by 1 when the request ends.|
|`panic`                     |C|✓|Number of runtime panics.|
|`projection_no_attribute`   |C| |Number of attributes projected but not present in each item.|
|`projection_not_a_list`     |C| |Number of attributes projected as a list type but not a list in each item.|
|`projection_list_index_oob` |C| |Number of attributes projected as a list but out of bounds for the list in each item.|
|`readfill_read`             |C| |Number of SQL reads for read-filling data.|
|`readfill_rows_missing`     |C| |Number of rows missing in SQL (for missfill).|
|`readfill_write`            |C| |Number of SQL writes for read-filling data.|
|`readfill_rows_written`     |C| |Number of rows backfilled into SQL on read.|
|`req`                       |C|✓|Number of _all_ requests. Includes control plane requests like `ListTables`.|
|`req_ctrl`                  |C|✓|Number of control plane requests handled by mlrd.|
|`req_delete`                |C| |Number of delete requests.|
|`req_delete_cond`           |C| |Number of delete requests with a conditional expression.|
|`req_delete_cond_fail`      |C| |Number of conditional delete requests that fail the condition check.|
|`req_fwd`                   |C|✓|Number of requests forwarded to DDB, usually control plane requests.|
|`req_get_batch`             |C| |Number of batch read item requests (`BatchReadItem`).|
|`req_get_one`               |C| |Number of single-item get requests (`GetItem`).|
|`req_get_one_nop`           |C| |Number of single-item get requests that did not match an item.|
|`req_put`                   |C| |Number of put (insert) requests.|
|`req_put_cond`              |C| |Number of put requests with a conditional expression.|
|`req_put_cond_fail`         |C| |Number of conditional insert requests that fail the condition check.|
|`req_query`                 |C| |Number of query requests (`Query`).|
|`req_query_index`           |C| |Number of query requests that specify a secondary index (_not_ the primary key).|
|`req_query_page`            |C| |Number of query requests that paginate by specifying starting key values (`ExclusiveStartKey`).|
|`req_read`                  |C| |Number of table data read requests.|
|`req_scan`                  |C| |Number of scan requests (`Scan`).|
|`req_scan_index`            |C| |Number of scan requests that specify a secondary index (_not_ the primary key).|
|`req_scan_page`             |C| |Number of scan requests that paginate by specifying starting key values (`ExclusiveStartKey`).|
|`req_table`                 |C| |Number of table data access requests (all table read and write requests). Use this metric to monitor table throughput as requests per second (RPS).|
|`req_update`                |C| |Number of update requests.|
|`req_update_cond`           |C| |Number of update requests with a conditional expression.|
|`req_update_cond_fail`      |C| |Number of conditional update requests that fail the condition check.|
|`req_write`                 |C| |Number of table data write requests.|
|`req_write_batch`           |C| |Number of batch write requests (`BatchWriteItem`).|
|`size_get_batch_items`      |G| |Number of items requested in `BatchGetItem`.|
|`size_write_batch_items`    |G| |Number of writes requested in `BatchWriteItem`.|
|`sql_delete`                |C| |Number of SQL DELETE executed (not rows deleted).|
|`sql_delete_nop`            |C| |Number of SQL DELETE that did not match a row.|
|`sql_insert`                |C| |Number of SQL INSERT executed (not rows inserted).|
|`sql_read`                  |C| |Number of SQL reads: row, set, and scan.|
|`sql_read_cond`             |C| |Number of SQL single-row reads for checking write condition.|
|`sql_read_row`              |C| |Number of SQL single-row reads (point lookups).|
|`sql_read_row_nop`          |C| |Number of SQL single-row reads that did not match a row.|
|`sql_read_set`              |C| |Number of SQL multi-row reads.|
|`sql_read_snapshot`         |C| |Number of SQL single-row reads for before/after/modified write values.|
|`sql_scan`                  |C| |Number of SQL multi-row reads by scanning the primary key or an index (not rows read).|
|`sql_scan_index`            |C| |Number of SQL multi-row reads by scanning a secondary index.|
|`sql_scan_filter`           |C| |Number of SQL multi-row reads with a filter condition.|
|`sql_scan_key_cond`         |C| |Number of SQL multi-row reads with a key condition.|
|`sql_scan_page`             |C| |Number of SQL multi-row reads with an index offset to fetch next page of result set.|
|`sql_scan_count`            |C| |Number of SQL multi-row reads that `SELECT COUNT(*)` instead of returning rows.|
|`sql_scan_nop`              |C| |Number of SQL multi-row reads that match zero rows (empty result set) because conditions don't match or no more pages.|
|`sql_update`                |C| |Number of SQL UPDATE executed (not rows updated).|
|`sql_upsert`                |C| |Number of SQL INSERT due to no row on UPDATE.|
|`sql_write`                 |C| |Number of SQL writes: INSERT, UPDATE, DELETE.|
|`t_req`                     |G|✓|Response time of _all_ requests.|
|`t_req_batch_read`          |G|✓|Response time of batch read requests.|
|`t_req_batch_write`         |G|✓|Response time of batch write requests.|
|`t_req_table_read`          |G| |Response time of table read requests.|
|`t_req_table_write`         |G| |Response time of table write requests.|
|`t_sql_read_row`            |G| |Response time of SQL single-row reads.|
|`t_sql_read_set`            |G| |Response time of SQL multi-row reads.|
|`t_sql_scan`                |G| |Response time of SQL scans.|
|`t_sql_delete`              |G| |Response time of SQL deletes.|
|`t_sql_insert`              |G| |Response time of SQL inserts.|
|`t_sql_update`              |G| |Response time of SQL updates.|
|`t_ddb_read`                |G| |Response time of DDB read requests.|
|`t_ddb_write`               |G| |Response time of DDB write requests.|

</div>
