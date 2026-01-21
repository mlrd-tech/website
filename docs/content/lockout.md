---
---

# Lockout {anchor=false}

To safeguard data integrity, mlrd enables read-only and lockout on a table due to a fault or write barrier.
Lockout means read-only cannot be turned off dynamically.

> [!DANGER]
> **WARNING**<br>
> Do not restart mlrd without analyzing and resolving the error that cuased the lockout!
> Failure to do so could cause data corruption in DynamoDB and the SQL store.

First check the logs to see if the lockout was due to a fault or write barrier.
Both are clearly logged with the word "FAULT" or "write barrier".

## Fault


## Write Barrier

