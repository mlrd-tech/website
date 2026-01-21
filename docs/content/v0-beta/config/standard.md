---
---

# Standard Config

## `aws`

An `aws` section configures AWS settings: region, profile, etc.

## Index

An index map sets [`ddb.primary_key`]({{< ref "table/#ddbprimary_key" >}}) and [`ddb.indexes`]({{< ref "table/#ddbindexes" >}}).
Every index must specify a `partition_key`.

### `partition_key`

|Metadata|Value|
|--------|-----|
|Description|Partition key code and attribute name, like "S,Title" (required)|
|Value Type|string|
|Valid&nbsp;Values|[Coded attribute]({{< ref "concepts/#coded-attribute" >}})|

### `sort_key`

|Metadata|Value|
|--------|-----|
|Description|Sort key code and attribute name, like "N,Year" (optional)|
|Value Type|string|
|Valid&nbsp;Values|[Coded attribute]({{< ref "concepts/#coded-attribute" >}})|

### `include`

|Metadata|Value|
|--------|-----|
|Description|List of attribute included (projected) in the index|
|Value Type|List of strings|
|Valid&nbsp;Values|[Top-level attribute]({{< ref "concepts/#top-level-attribute" >}}) names|

## `metrics`

### `metrics.endpoint`

|Metadata|Value|
|----|-----|
|Description|OpenTelemetry URL|
|Value Type|string|
|Valid&nbsp;Values|URL|
|Default&nbsp;Value||

### `metrics.freq`

|Metadata|Value|
|----|-----|
|Description|Frequency at which metrics are reported|
|Value Type|string|
|Valid&nbsp;Values|Go time duration|
|Default|"5s"|

### `metrics.percentiles`

|Metadata|Value|
|----|-----|
|Description|Percentiles to report|
|Required|No|
|Value Type|List of floats|
|Valid&nbsp;Values|Between 1 and 100|
|Default&nbsp;Value|`[95, 99]`|

## `mysql`

```yaml
mysql:
  hostname: ""
  socket: ""
  username: ""
  password: ""
  password_file: ""
  db: ""
  table_name: ""
  tls: {}
  aws: {}
```

`hostname`, `socket`, `username`, `password`, and `db` are not documented because they are standard settings that work the same in mlrd.

### `mysql.password_file`

|Metadata|Value|
|----|-----|
|Description|File name containing password, takes precedence over `mysql.password`|
|Value Type|string|
|Valid&nbsp;Values|File name, relative or absolute path|
|Default&nbsp;Value||

### `mysql.table_name`

|Metadata|Value|
|----|-----|
|Description|MySQL table name. Can be different than [`ddb.table_name`]({{< ref "table/#ddbtable_name" >}}), but clients always access the table by `ddb.table_name`, never by `mysql.table_name`.|
|Value Type|string|
|Valid&nbsp;Values|MySQL table name|
|Default&nbsp;Value|[`ddb.table_name`]({{< ref "table/#ddbtable_name" >}})|


## `tls`


