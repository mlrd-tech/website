---
---

# sys Config

The sys config is an optional YAML file that defines system settings and certain table config default values.
The sys config is set on startup with the `-sys` flag.

## `api`

The `api` section configures the mlrd API.

### `api.addr`

|Metadata|Value|
|--------|-----|
|Description|Bind address and port|
|Value Type|string|
|Valid Values|Standard "addr:port" notation|
|Default&nbsp;Value|":7999"|

### `api.control_plane`

TODO

## `log`

The `log` section configures mlrd logging.
There are seven subsystems for logging:

* `init`: Startup, config validation
* `api` : HTTP server, endpoint handlers, shutdown
* `table`: Migration, backfill, table-specific events after startup
* `ddb`: AWS and DynamoDB client
* `sql`: SQL store connection, queries
* `expr`: Expression parsing
* `metrics`: Metric recording and reporting

Subsystem log levels are set by this precedent:

1. All subsystems set to debug if [`-debug`]({{< ref "command-line" >}}) is set
2. All subsystems set to `log.level` if set
3. `init` subsytem set to info, all others set to warn 

For example, to increase only `sql` subsys logging to debug:

```yaml
log:
  subsys:
    sql: debug
```

### `log.text`

|Metadata|Value|
|--------|-----|
|Description|Output text logs instead of JSON|
|Value Type|bool|
|Valid Values|`true` or `false`|
|Default&nbsp;Value|`false`|

### `log.level`

|Metadata|Value|
|--------|-----|
|Description|Log level for all subsys|
|Value Type|string|
|Valid Values|error, warn, info, debug, "" (no value)|
|Default&nbsp;Value||

### `log.subsys`

|Metadata|Value|
|--------|-----|
|Description|Log level for each subsystem|
|Value Type|map|
|Valid Values|keys: subsys name<br>values: log level|
|Default&nbsp;Value|init: info<br>api: warn<br>table: warn<br>ddb: warn<br>sql: warn<br>expr: warn<br>metrics: warn|

## `disable`

|Metadata|Value|
|--------|-----|
|Description|Global list of feature flags to disable for all tables|
|Value Type|list of strings|
|Valid Values|[Feature flags]({{< ref "feature-flags" >}})|
|Default&nbsp;Value||

## `metrics`

|Metadata|Value|
|--------|-----|
|Description|Bind address and port|
|Value Type|string|
|Valid Values|Standard "addr:port" notation|
|Default&nbsp;Value|":7999"|


