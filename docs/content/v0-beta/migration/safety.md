---
---

# Safety {anchor=false}

## Interlocks

Migration safety interlocks prevent mlrd from writing data unless certain conditions are true.
Interlocks exist the `_migration` table:

```
CREATE TABLE _migration (
  `table_name` varchar(128) NOT NULL,
  `interlock`  varchar(128) NOT NULL,
  `value`      varchar(128) DEFAULT NULL,
  PRIMARY KEY (table_name, interlock)
);
```

These are the interlocks:

|Interlock | Value |
|----------|-------|
|`backfill-lock` | mlrd instance ID that has acquired the backfill lock |
|`write-barrier` | `1` or `2` |

To create an interlock, insert the row:

```sql
INSERT IGNORE INTO mlrd._migration (tableName, interlock) VALUES ('Foo', 'write-barrier-1');
```

## Why Writes Must Stop

![Lost Write](/img/mlrd_lost_write.png)
