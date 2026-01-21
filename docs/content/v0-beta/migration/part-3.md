---
title: "Part 3: Verify SQL"
---

# Part 3: Verify SQL Store {anchor=false}

![mlrd Migration Phase 3](/img/mlrd_migration_phase_3.png)

1. When backfill is done, dynamically change mode to `trx-write` to read from MySQL, write to MySQL and DDB--this will disable writes
2. When all nodes in `trx-write` step, dynamically enable writes
3. Set `migrationStep: trx-write` in config and roll out
