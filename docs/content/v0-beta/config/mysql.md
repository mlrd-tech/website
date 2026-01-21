---
title: "MySQL"
---

# MySQL

mlrd is developed on MySQL Community Edition v8.4 but also supports:

|MySQL Version|Tested|Supported|Recommended|
|-------------|------|---------|-----------|
| &ge; v8.0.32 | ✅   | ✅     |           |
| **v8.4 LTS** | ✅   | ✅     | ✅        |
| v9.x         |      |        |           |

## User

Presuming:

* User: `mlrd`
* Password: `...`
* Database: `mlrd`

Use `caching_sha2_password` and grant full access only to the database that mlrd uses:

```sql
CREATE USER IF NOT EXISTS mlrd IDENTIFIED WITH caching_sha2_password BY '...';

GRANT ALL ON mlrd.* TO mlrd@'%';
```
