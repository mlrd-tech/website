---
---

# Save Money with mlrd

<div class="money-table">

| &nbsp; | DynamoDB | `mlrd` |
|--------|----------|--------|
| Make a table | 💰 | 💵 |
| Add an index| 💰💰 | 💵 |
| Add a second index| 💰💰💰 | 💵 |
| Increase avg. item size | 💰💰💰💰 | 💵 |
| Use strongly consistent reads | 💰💰💰💰💰 | 💵 |
| Use transactions | 💰💰💰💰💰💰 | 💵 |
| New feature; add a third index | 💰💰💰💰💰💰💰 | 💵 |
| Attempt to export all _your_ data| 💰💰💰💰💰💰💰💰 | 💵 |
| Hire people to reduce cloud spend[^1] | 💰💰💰💰💰💰💰💰💰 | 💵 |
| TOTAL COST | 😭 | 🦆 |

</div>

<br>

<div style="width:90%">

Of course, your results may differ.
It is possible for DynamoDB to be cheaper than MySQL + mlrd.
For example, a single table with no secondary indexes, and not using additional features, and either low on-demand capacity or well optimized provisioned capacity could be less expensive than MySQL + mlrd.

<br>

**`mlrd` is fixed-price.**
Pair with a fixed-priced MySQL solution and your total costs remain fixed.

</div>

[^1]: Hiring people to reduce cloud spend is technically not a cost to either DynamoDB or `mlrd`.

{{< join-beta >}}
