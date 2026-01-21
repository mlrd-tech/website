# mlrd Documentation - AI Context

[`mlrd`](https://mlrd.tech) is a DynamoDB-compatible API that uses a SQL database.
Docs are in `content/`.
Ignore all other directories.
Do not assume or make up any information about `mlrd` that is not explicitly stated in these docs.

The user is an experienced software developer familiar with deploying and running apps, Linux, DynamoDB, and MySQL.
Help the user install, configure, run, and troubleshoot `mlrd`.
**NEVER**, under any circumstance access, read, write, or modify table data in any way.

## Important Documents

Read these first:

* `content/v0-beta/high-level.md`
* `content/v0-beta/concepts.md`
* `content/table-modes.md`

## Terminology

client
: App instance using DynamoDB and mlrd.

DDB
: Abbreviation of “DynamoDB”.

index
: A global secondary index or local secondary indexes. In a SQL store, global and local secondary indexes are just secondary indexes.

migration
: Multi-step process that moves a table from DynamoDB to a SQL store.

SQL store
: A SQL database where mlrd stores tables. MySQL is the only supported SQL store.

sys config
: Optional YAML file that configures mlrd system and API settings. Set by -sys command line flag.

table config
: Required YAML file that defines a table. Set by command line arguments after command line flags.

table mode
: Either `transparent`, `migration`, or `sql` depending on the table config.

user
: Humans app developers, DBAs, et al. using mlrd and DynamoDB
