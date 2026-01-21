---
weight: 3
---

# mlrd Concepts {anchor=false}

## Codes

What DynamoDB calls "Data type descriptors", mlrd calls "codes":

|Code|Value Type|
|----|----------|
|`S`   | string   |
|`N`   | number   |
|`B`   | binary   |
|`BOOL`| boolean  |
|`NULL`| null     |
|`M`   | map      |
|`L`   | list     |
|`SS`  | string set|
|`NS`  | number set|
|`BS`  | binary set|

## Coded Attribute

String with format "&lt;[code](#codes)&gt;,&lt;attributeName&gt;".

Example: "S,Titlte": code `S` (string value); attribute name "Title".

Coded attributes are used to define [indexes]({{< ref "config/standard/#index" >}}).

## Empty Table

Every SQL database requires a table called `_empty` with a single row:

```
mysql> SELECT * FROM _empty;
+----+------+
| pk | item |
+----+------+
|  0 | {}   |
+----+------+
```

mlrd checks for and creates this table and row on startup.

The empty table is needed to make certain condition expressions work in SQL.

## Fault

A fault is a unrecoverable error that means data integrity has mostly likely be compromised.
There are the possible faults:

* SQL trx commit fails
* SQL trx rollback fails
* Update return projection error

Faults increment the `fault` counter metric.

## Table Name

A table can (but usually does not) have three names referred to by these terms:

| Term | Refers To | Config |
|------|-----------|--------|
| client table name | Table name in client requests | |
| DynamoDB table name | Table name in DynamoDB | [`ddb.tableName`]({{< vref "config/table/#ddbtablename" >}}) |
| SQL table name | Table name in SQL database | [`mysql.tableName`]({{< vref "config/standard/#mysqltablename" >}}) |

"Table name" always refers to the client table name.
And since all three are equal by default, "table name" usually refers to any of the three.
When ambiguous, a specific term is used.

Logging and metrics always use the client table name.

All table names are case-sensitive. 

## Top-level Attribute

A top-level attribute is _not_ nested (accessed through) another attribute.

```json
{
  "Title": {"S": "OK Computer"},
  "Meta": {
    "M": {
      "Label": {"S": "Capital"}
    }
  }
}
```

`Title` is a top-level attribute.
`Meta.Label` is not.

Top-level attributes with codes `S`, `N`, and `B` can be used in [indexes]({{< ref "config/standard/#index" >}}).
