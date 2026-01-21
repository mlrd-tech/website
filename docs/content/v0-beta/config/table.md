---
---

# Table Config

A table config is a YAML file that defines one table in the SQL store and DDB.
Every table requires a table config.
Each table config is complete and independent; there are no shared table config settings or values.

When mlrd starts, it reads a list of table config files, like:

```sh
$ mlrd foo.yaml bar.yaml
```

Files `foo.yaml` and `bar.yaml` specify two tables.

Table names are set by `ddb.table_name` and must be unique.
If a client requests a table that does not exist, mlrd returns HTTP 400 and an "unknown table" error message.

Two settings are always required: `ddb.table_name` and `ddb.primary_key`.

Addition setting required based on [table mode]({{< ref "table-modes" >}}):

|Table Mode   |Required Settings|
|-------------|--------|
|`sql`        | `ddb` and `mysql`|
|`migration`  | `ddb` and `mysql` and `migrationStep`|
|`transparent`|`ddb` |

## `ddb`

The `ddb` section defines the table for both DynamoDB and the SQL store.
Settings `ddb.table_name` and `ddb.primary_key` are always required.

### `ddb.indexes`

|Metadata|Value|
|--------|-----|
|Description|Secondary index definitions|
|Value Type|map|
|Valid&nbsp;Values|keys: index name<br>values: [Standard index]({{< ref "standard/#index" >}})|
|Default&nbsp;Value||

### `ddb.primary_key`

|Metadata|Value|
|--------|-----|
|Description|Primary key definition (required)|
|Value Type|map|
|Valid&nbsp;Values|[Standard index]({{< ref "standard/#index" >}})|
|Default&nbsp;Value||

### `ddb.table_name`

|Metadata|Value|
|--------|-----|
|Description|Table name (required)|
|Value Type|string|
|Valid&nbsp;Values|DynamoDB table name|
|Default&nbsp;Value||

## `disable`

|Metadata|Value|
|--------|-----|
|Description|List of feature flags to disable in addition to [`sys.disable`]({{< ref "sys#disable" >}}). Feature flags disabled at the system level cannot be re-enabled at the table level.|
|Value Type|list of strings|
|Valid&nbsp;Values|[Feature flags]({{< ref "feature-flags" >}})|
|Default&nbsp;Value||

## `migration_step`

|Metadata|Value|
|----|-----|
|Description|Migration step name|
|Required|Only when migrating a table|
|Value Type|string|
|Valid&nbsp;Values|[Migration step name]({{< ref "migration/#steps" >}})|
|Default&nbsp;Value||

## `mysql`

[`mysql` standard config]({{< ref "standard/#mysql" >}})
