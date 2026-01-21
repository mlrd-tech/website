---
title: "Part 4: Cut Over"
---

# Part 4: Cut Over to SQL Store {anchor=false}

![mlrd Migration Phase 4](/img/mlrd_migration_phase_4.png)

1. Roll out deploy with `migrationStep: sql`
2. Verify everything still works
3. Remove `migrationStep` and roll out again to put table in SQL mode

> Option to make canary write PK to file. on rollback, read PK from MySQL, write to DDB
