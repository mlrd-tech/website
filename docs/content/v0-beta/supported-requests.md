---
---

# Supported Requests

* Classic API: fully supported
* Control Plane: when applicable
* TTL: not supported
* PartiQL: not supported
* Streams: not supported

| Request | Supported? | Notes |
|---------|------------|-------|
|BatchExecuteStatement| No | PartiQL not supported |
|**BatchGetItem** | ✅| |
|**BatchWriteItem** | ✅| |
|CreateBackup | No | |
|CreateGlobalTable | No | |
|CreateTable | ✅ ||
|DeleteBackup | No | |
|**DeleteItem** | ✅ || 
|DeleteResourcePolicy | No | |
|DeleteTable  | ✅| |
|DescribeBackup | No | |
|DescribeContinuousBackups | No | |
|DescribeContributorInsights | No | |
|DescribeEndpoints | No | |
|DescribeExport | No | |
|DescribeGlobalTable | No | |
|DescribeGlobalTableSettings | No | |
|DescribeImport | No | |
|DescribeKinesisStreamingDestination | No | |
|DescribeLimits | No | |
|DescribeTable  | ✅| |
|DescribeTableReplicaAutoScaling | No | |
|DescribeTimeToLive | No | |
|DisableKinesisStreamingDestination | No | |
|EnableKinesisStreamingDestination | No | |
|ExecuteStatement | No | PartiQL not supported |
|ExecuteTransaction | No | PartiQL not supported |
|ExportTableToPointInTime | No | |
|**GetItem**  | ✅| |
|GetResourcePolicy | No | |
|ImportTable | No | |
|ListBackups | No | |
|ListContributorInsights | No | |
|ListExports | No | |
|ListGlobalTables | No | |
|ListImports | No | |
|ListTables  | ✅| |
|ListTagsOfResource | No | |
|**PutItem**  | ✅| |
|PutResourcePolicy | No | |
|**Query**  | ✅| |
|RestoreTableFromBackup | No | |
|RestoreTableToPointInTime | No | |
|**Scan**  | ✅| |
|TagResource | No | |
|TransactGetItems  | In progress| |
|TransactWriteItems | In progress ||
|UntagResource | No | |
|UpdateContinuousBackups | No | |
|UpdateContributorInsights | No | |
|UpdateGlobalTable | No | |
|UpdateGlobalTableSettings | No | |
|**UpdateItem** | ✅ ||
|UpdateKinesisStreamingDestination | No | |
|UpdateTable | Planned | |
|UpdateTableReplicaAutoScaling | No | |
|UpdateTimeToLive | No | |
