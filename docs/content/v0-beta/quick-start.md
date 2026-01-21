---
weight: 1
---

# Quick Start

Example table:

* Name: `Books`
* Primary Key:
  * Partition Key: `Title` (string)
  * Sort Key: `Year` (number)
* Indexes:
  * `ISBN`
    * Partition Key: `ISBN` (string)

## New Table

1. Write table config `Books.yaml`:

```yaml
ddb:
  table_name: Books
  primary_key:
    partition_key: "S,Title"
    sort_key: "N,Year"
  indexes:
    ISBN:
      partition_key: "S,ISBN"

mysql:
  hostname: 10.0.0.75:3306
  username: mlrd
  password: ${MLRD_MYSQL_PASSWORD_BOOKS} # env var
  db: mlrd
```

2. Start `mlrd`

```sh
$ mlrd Books.yaml
```

3. Reconfigure App

Varies by langauge and AWS SDK, but goal is to set:

* Region: "local" is a good value since `mlrd` is local to you
* Credentials provider: AWS access keys and IAM auth are _not_ needed with `mlrd`
* BaseEndpoint: URL of your `mlrd` server

In Go with AWS SDK v2:

```go
import (
    "github.com/aws/aws-sdk-go-v2/aws"
    "github.com/aws/aws-sdk-go-v2/credentials"
    "github.com/aws/aws-sdk-go-v2/service/dynamodb"
)

opts := dynamodb.Options{                               
    Region:       "local",
    Credentials:  credentials.NewStaticCredentialsProvider("local", "local", "local"),
    BaseEndpoint: aws.String("http://10.0.0.1:7999"),

    DisableValidateResponseChecksum: true,
}

client := dynamodb.New(opts)
```

> [!NOTE]
> **AWS Config**<br>
> There are _many_ ways to configure AWS. Consult the AWS SDK docs for your language and SDK. 

## Test App with Existing Table

Follow the steps above but _remove the `mysql` section_ from `Book.yaml`

A table config with no `mysql` section or `migration_step` setting puts the table in [transparent mode]({{< ref "table-modes" >}}), which makes `mlrd` act like a transparent proxy for the table and only return DynamoDB errors; `mlrd` errors are only logged.

Run `mlrd` for days or weeks to ensure that, at a basic level, it can handle the application-specific workload.
