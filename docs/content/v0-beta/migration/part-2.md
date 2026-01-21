---
title: "Part 2: Backfill"
---

# Part 2: Backfill and Dual-write Data {anchor=false}

![mlrd Migration Phase 2](/img/mlrd_migration_phase_2.png)

1. Create empty backfill lock: `INSERT INTO mlrd._migration (tableName, flag) VALUES ('...', 'backfill')`
2. Start _one_ `mlrd` in a backfill mode
3. Dump DynamoDB table and load into MySQL but _do not_ overwrite existing items because anything already present in MySQL is from a write


* DynamoDB is written to _first_ and remains authoritative (the source of truth)
* MySQL is written to second (as shown in the `Write2` column above)
* Backfill writes are authoritative

> Items in MySQL are newest: either from a mirror write or a backfill
> MySQL write error during backfill: OK, just be sure to log and retry/re-backfill the item(s)
