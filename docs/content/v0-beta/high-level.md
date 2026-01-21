---
weight: 2
---

# High Level {anchor=false}

## `mlrd` Server

* `mlrd` is a DynamoDB-compatible API that uses an SQL store (currently only MySQL)
* Clients (i.e. the application) connect to `mlrd` instead of DynamoDB
* The default `mlrd` port is `7999`
* A single `mlrd` instance can handle many tables
* Multiple `mlrd` instances can be run for the same tables, but currently `mlrd` uses a shared-nothing design; therefore, be careful to configure each `mlrd` instances identically (a future version of `mlrd` will use a shared control plane)
* The `mlrd` server (API, logging, etc.) is configured with an optional YAML file called a ["sys config"]({{< ref "config/sys" >}})
* Use the `-sys` command line flag to set a sys config
* `mlrd` defaults to structured log output on STDOUT with log levels `error`, `warn`, `info`, and `debug` for `CreateTable` requests
* `mlrd` prints to STDERR only if startup fails before initializing logging; else, `mlrd` logs only to STDOUT as configured
* Table configs are specified as command line arguments (after any command line flags), like `mlrd tbl_A.yaml tbl_B.yaml`
* If no table configs are specified, `mlrd` uses it `controlPlane` sys config settings to create new tables for `CreateTable` requests
* On startup, `mlrd` validates config files, initialize logging and metrics, creates DynamoDB clients, checks each table config and corresponding SQL table, adds missing SQL tables or indexes, and starts the API
* Use the `-initcheck` command line flag to run the startup sequence then exit; if successful, it prints "init check OK" and exits zero; else it prints an error and exists non-zero
* Currently, `mlrd` does not use or set a PID file
* To stop `mlrd`, send an interrupt or SIGTERM signal

## Tables

* Tables are uniquely identified by a case-sensitive name
* Each table must be defined in YAML file called a ["table config"]({{< ref "config/table" >}})
* Each table config is completely self-contained and independent; if, for example, two tables use the same MySQL settings, both table configs need a copy of those MySQL settings
* The minimal table config defines `ddb.tableName` and `ddb.primaryKey`; this would define a table in transparent mode 
* Each table runs in one [table mode]({{< ref "table-modes" >}}):
  * `transparent`: `mlrd` acts likes a transparent proxy for _all_ requests; used to test and verify `mlrd` with the application
  * `migration`: `mlrd` dual-writes and dual-reads DynamoDB and the SQL store depending on the migration step; a migration moves data from DynamoDB to the SQL store, ultimately allowing the application to stop using the DynamoDB table
  * `sql`: `mlrd` uses only the SQL store; DynamoDB is not accessed
* A transparent mode table returns only DynamoDB errors; `mlrd` errors, if any, are only logged
* Before migrating an existing DynamoDB table to the SQL store, the table should be run in transparent mode for days or weeks to ensure that `mlrd` can parse and handle all request parameters
* Migrating a DynamoDB table to the SQL store is a four-part, multi-step process that should be performed by experienced app developers and DBAs
* Net-new tables can be created in SQL mode by specifying a table config that includes a `ddb` section, a `mysql` section, and _no_ `migration` value.
* For all table modes, a table config is required that defines the table in the `ddb` section

## Metrics

* `mlrd` collects and reports a comprehensive set of counter and gauge metrics
* Metrics are reported per-table with a `table_name` tag (aka label, attribute, or dimension)
* Metrics are OpenTelemetry and reported to an OpenTelemetry endpoint
* Metric reporting frequency is as fast as 1 second (maximum resolution); the default is 5 seconds

## Supported Requests

* `mlrd` is fully-compatible with the DynamoDB data plane classic API: `GetItem`, `BatchGetItem`, `Query`, `Scan`, `PutItem`, `UpdateItem`, `DeleteItem`, `BatchWriteItem`
* Support for `TransactGetItems` and `TransactWriteItems` are still in development
* `mlrd` is fully-compatible with all expressions: `ConditionExpression`, `FilterExpression`, `UpdateExpression`, `KeyConditionExpression`, and `ProjectionExpression`.
