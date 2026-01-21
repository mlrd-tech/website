---
---

<div style="font-size:2rem">

> [!DANGER]
> **Beta Preview Docs**<br>
> mlrd is in private beta, so these docs are only a _preview_.<br>
> Information in these docs will change.

</div>

# Ask, Don't Read!

Use [Claude](https://claude.ai/) (or your preferred AI) to read these docs and help you.

AI is _really good_ as reading docs and answering questions based on the docs.

Save yourself a lot of time and just ask AI.

Here's an example:

> How do I add an index to my table config? The index is just a partition key on attribute "Year", a number. 

Claude Sonnet 4.5 says:

<div style="border:1px solid grey; border-radius:15px; padding:0.5em;">

● Based on the documentation, here's how to add an index to your table config:

```yaml
  ddb:
    indexes:
      YearIndex:  # choose any name for your index
        partitionKey: "N,Year"
```

  The key points:
  - ddb.indexes is a map where keys are index names (you can choose any name)
  - Each index requires a partitionKey field
  - The partition key uses a coded attribute format: "N,Year" where:
    - N is the code for number type
    - Year is your attribute name

  This is documented in content/v1.0/config/standard.md:10-22 and content/v1.0/concepts.md:22-28.
</div>

Spend your time programming, not reading docs!
