---
---

# Feature Flags {anchor=false}

|Flag|Disables|
|----|--------|
| `sql-create-data-table` | Automatic data table creation on startup |
| `sql-create-empty-table` | Automatic empty table creation on startup |
| `sql-init-empty-table` | Inserting empty item into empty table on startup |
| `sql-data-table-check` | Checking data table (columns, indexes, etc.) on startup |
| `sql-empty-table-check` | Checking empty table on startup |
| `sql-index-check` | Checking indexes in data tables on startup |
| `sql-create-indexes` | Creating missing indexes in data tables on startup |
| `sql-index-visible-warning` | Warning about SQL data table indexes that are visible but not defined in the table config |
| `sql-index-invisible-warning` | Warning about SQL data table indexes that are invisible |
| `aws-auto-region` | Auto-detecting AWS region using IMDS | 
| `aws-rds-tls` | Automatically using AWS RDS CA |
| `strict-index-projection` | DynamoDB strict projection expression for secondary indexes |
| `ddb-auto-table` | Using `DescribeTable` to automatically define primary key and secondary table indexes in the table config |
| `write-new-config-files` | API control plane writing new table config files for newly created tables |
| `mysql-tls` | Using TLS for MySQL TCP connections |
| `safe-logging` | <span style="color:red">**DO NOT DISABLE IN PRODUCTION**</span><br>Redaction of data values in log messages, including API requests and SQL queries&mdash;this is very dangerous!|
