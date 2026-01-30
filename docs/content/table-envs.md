---
weight: 100
---

# Table Envs

One table licenses allows N-many _environments_ ("envs") like dev, staging, and production.

Suppose your production table name is `Books` and the license allows 4 table envs.
Then you might have:

| &nbsp; | Table Name | Env |
|--------|-----------|-----|
| 1. | `Books` | production |
| 2. | `Books_staging` | staging |
| 3. | `Books_dev` | dev |
| 4. | `_new_Books` | dev experiment |

We're developers, too, so we know that non-production tables are necessary, but they don't make money like production.
So most `mlrd` table licenses give you non-production tables for free.

## Common Table Name

The first table name serves as the _common table name_ (CMT): the name that all environments have in common.
For example, if your table is `books_staging` in staging and `books` in production, the CMT is `books`.
The CMT counts as 1 environment and is usually the production table name.

## Matching

For each license, all table names for all envs must contain the CMT (case-insensitive) and not be a duplicate.
For example, if the CMT is `Books`, then:

<table>
<tr>
<th>✅ Matches</th>
<th>⛔ Does Not Match</th>
<tr>
<tr>
<td>
<pre><code>staging_books
books_dev
__copy_of_books</code></pre>
</td>
<td>
<pre><code>Books
book
Albums</code></pre>
</td>
</td>
</table>

Table names and envs are not locked in; you can change them.
If `Books` becomes `Albums`, you can manually edit the table allocation to change all the table names at once.

## Auto-Match and Assign

If `mlrd` uses a table that does not exist in any env, the table will be automatically added to the env if it matches the CMT and there's a free env.
If not, the table will be disabled (`mlrd` won't serve requests to the table).
