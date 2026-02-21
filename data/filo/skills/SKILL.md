---
name: filo
description: FiloDB is a distributed, in-memory time-series database designed for massive scalability and Prometheus compatibility.
homepage: https://github.com/filodb/FiloDB
---

# filo

## Overview
FiloDB is a distributed, in-memory time-series database designed for massive scalability and Prometheus compatibility. It is primarily used for real-time operational metrics, distributed tracing, and high-concurrency dashboarding. This skill provides guidance on building the FiloDB components, initializing the underlying Cassandra storage schemas, and utilizing the native command-line interface for database operations.

## Core Workflows

### Building the Environment
FiloDB requires Java 11 and SBT. Use the following patterns to build the necessary artifacts:

- **Build all components**: `sbt standalone/assembly cli/assembly gateway/assembly`
- **Build Spark integration**: `sbt spark/assembly`

### Schema Initialization
Before ingesting data, you must initialize the Cassandra keyspaces. The `schema-create.sh` script generates the necessary CQL.

**Standard Initialization Pattern:**
```bash
./scripts/schema-create.sh <admin_keyspace> <data_keyspace> <downsample_keyspace> <dataset_name> <num_shards> <replica_settings>
```

**Example for local development:**
```bash
./scripts/schema-create.sh filodb_admin filodb filodb_downsample prometheus 4 1,5 > /tmp/ddl.cql
cqlsh -f /tmp/ddl.cql
```

### CLI Operations
The `filo-cli` is the primary tool for administrative tasks and ad-hoc querying.

- **Initialization**: Use the CLI to define datasets and column schemas.
- **Querying**: Execute PromQL queries directly against the FiloDB cluster.
- **Node Management**: Monitor shard assignments and cluster status.

## Best Practices
- **Memory Management**: FiloDB uses off-heap memory to minimize GC overhead. Ensure your environment has sufficient non-heap memory allocated.
- **Kafka Partitioning**: Match your Kafka partition count to your FiloDB shard count (or a multiple thereof) to ensure even distribution.
- **Storage Backend**: While Cassandra is the default, ScyllaDB is supported for higher performance requirements.
- **Data Modeling**: Use the Prometheus schema for operational metrics to leverage tag-based indexing and fast lookups.

## Troubleshooting
- **Port Conflicts**: Ensure port `8080` is available; newer ZooKeeper versions often have an AdminServer that conflicts with FiloDB. Disable it in `zoo.cfg` using `admin.enableServer=false`.
- **M1/M2 Mac Issues**: If running locally on Apple Silicon, you may need to manually swap the JNA library in the Cassandra `lib` folder to version 5.10.0 or higher to avoid startup failures.

## Reference documentation
- [FiloDB README](./references/github_com_filodb_FiloDB.md)