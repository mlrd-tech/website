---
---

# Migration {anchor=false}

Migrating a table from DynamoDB to mlrd is standard four-part process:

| Part | Goal | mlrd Migration Steps| Saftey Interlock |
|-------|------|--------------------|------------------|
|1 | Ensure mlrd compatibility     | 1 | |
|2 | Backfill and dual-write data  | 2, 3, 4 | Backfill Lock |
|3 | Verify SQL store | 5, 6 | Write barrier 1 |
|4 | Cut over to SQL store | 7 | Write barrier 2 |

These are the steps:

```
#| Step        | Read1    | Read2    || Write1 | Write2 |
 |-------------|----------|----------||--------|--------|
1| ddb         | ddb      |          || ddb    |        |
 |- - - - - - - - - - - - - - - - - - - - - - - - - - - |Backfill Lock
2| backfill    | ddb      |          || ddb    | mysql  |
3|   readfill  | ddb -> W2|          || ddb    | mysql  |
4|   missfill  | ddb      |mysql-> W2|| ddb    | mysql  |
 |------------------------------------------------------|Write Barrier 1
5| trx-write   | mysql    |          || trx<mysql, ddb> |
6| pre-sql     | mysql    |          || mysql  | ddb    |
 |======================================================|Write Barrier 2
7| sql         | mysql    |          || mysql  |        |
```

The ASCII table above shows read and write order for each step.
The `-> W2` in steps 3 and 4 means "then Write2: mysql".
The `trx<>` in step 5 means "in a SQL transaction".

<br>

## Step 1: ddb

![mlrd Migration Part 1](/img/mlrd_migration_phase_1.png)

Step 1 is easy: connect the app to mlrd instead of DynamoDB, and mlrd reads and writes to DynamoDB on behalf of the app.

This is done to ensure mlrd can completely and correctly handle the app workload.
As noted in [Table Modes]({{< ref "table-modes" >}}), mlrd is _not_ transparent in the `ddb` migration step; any mlrd errors are returned to the client.

If the app and mlrd work correctly in `ddb` for a few days or weeks, then it's time to backfilling data into the MySQL&mdash;the SQL store.

<br>

## Steps 2&ndash;4: Backfill

![mlrd Migration Part 2](/img/mlrd_migration_phase_2.png)

Steps 2&ndash;4 introduce dual writes to help backfill data from DynamoDB to MySQL.

Only one mlrd instance back run in a backfill step.
This is enforced by requiring the backfill lock.

There are critically important reasons for backfill lock safety; see [Part 2: Backfill]({{< ref "part-2" >}}) for details.

mlrd dual writing to DynamoDB and then MySQL is only half the backfill.
The other half is dumping data from DynamoDB and loading into MySQL, which is done separately.

<br>

## Steps 5 and 6: Verify SQL

![mlrd Migration Part 3](/img/mlrd_migration_phase_3.png)

Steps 5 and 6 change the source of truth from DynamoDB to MySQL _with the ability to roll back_.

MySQL becomes `Write1` and DynamoDB becomes `Write2`.

These steps verify the SQL store in two ways:
* Data: Reads are served from MySQL, and configurable amount of shadow reads are made from DynamoDB to verify that MySQL and DynamoDB return the same data
* Load: Full read and write workload reveals if the SQL store performs up to expectations

For a mlrd instance to run in either step, write barrier 1 must exist; see [Safety]({{< ref "safety" >}}) for details.

Rolling forward from backfill steps to these steps requires that _all_ writes be stopped; see [Part 3: Verify SQL]({{< ref "part-3" >}}) for details.

Rolling back to backfill steps (to make DynamoDB the `Write1` source of truth again) is possible, too, _as long as no [faults]({{< ref "concepts/#fault" >}}) occur during these steps_.

<br>

## Step 7: Cut Over

![mlrd Migration Part 4](/img/mlrd_migration_phase_4.png)

Step 7 stops dual writing to DynamoDB.

As such, there's no return to DynamoDB after step 7 because the moment a single mlrd instances runs in step 7 and writes to MySQL, that write is not present in DynamoDB, which means DynamoDB data is invalid.
