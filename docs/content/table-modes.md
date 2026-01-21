---
weight: 80
---

# Table Modes

A table runs in a mode determined by its [table config]({{< vref "config/table" >}}):

|Table&nbsp;Mode|Table Config|DynamoDB Access|SQL Store Access|Source of Truth|
|---------------|------------|---------------|----------------|---------------|
|SQL        |`ddb`<br>`mysql`| | ✅| SQL store|
|Migration  |`ddb`<br>`migration`<br>`mysql`| ✅| ✅ | Depends on migration step|
|Transparent|`ddb`| ✅| | DymamoDB|

## SQL

SQL table mode uses only a SQL store; there is no DynamoDB access.

Use this mode for net-new tables.

## Migration

Migration table mode is used to move a table from DynamoDB to a SQL store.

Setting [`migration_step`]({{< vref "config/table/#migration_step" >}}) in a table config puts the table in migration mode.

The difference between transparent mode and the `ddb` migration step is that mlrd returns parsing errors to the client in migration mode.

[Migrating a table]({{< vref "migration/" >}}) is a multi-step process that requires careful planning and execution.
Read the migration docs carefully and have another engineer double-check everything.

Migration mode is the path to the end goal of mlrd: SQL table mode.

## Transparent

Transparent table mode is used to test mlrd with a table in DynamoDB (not a SQL store).

In transparent mode, mlrd acts as a transparent proxy between the client and DynamoDB.
All requests are sent to DynamoDB.
All values and errors (if any) from DynamoDB are sent back to the client.

Before sending a request to DynamoDB, mlrd parses the request.
mlrd parsing errors are only logged, not returned to the client.

> [!NOTE]
> **Basic Request Testing**<br>
> Transparent mode tests only request parsing (expressions, parameters, and so on).
> A table that works in transparent mode might fail in migration or SQL mode.

Transparent mode is a precursor to the first migration step: `ddb`.


