---
name: arvados-python-client
description: The arvados-python-client provides command-line tools for interacting with the Arvados API and Keep storage system to manage large-scale biomedical data. Use when user asks to upload files to Keep, inspect object metadata, list collections, copy resources between clusters, or generate deduplication reports.
homepage: https://github.com/curoverse/arvados/tree/main/sdk/python
---

# arvados-python-client

## Overview
The `arvados-python-client` provides a suite of command-line tools designed to interact with the Arvados API and Keep storage system. This skill enables efficient management of large-scale biomedical data by leveraging Arvados' content-addressed storage. Use these tools to upload datasets, inspect collection metadata, and manage data across different Arvados clusters while benefiting from built-in features like automatic deduplication and data provenance.

## Core CLI Tools and Patterns

### Data Upload and Storage (arv-put)
Use `arv-put` to upload files or directories into Arvados Keep.
- **Basic Upload**: `arv-put <path/to/data>`
- **Specify Storage Class**: Use `--storage-classes` to define the underlying storage tier (e.g., `cold`, `archive`).
- **Set Replication**: Use `--replication N` to ensure the data is stored across N different nodes.
- **Output**: The command returns a Collection UUID and a Portable Data Hash (PDH).

### Object Inspection (arv get)
Retrieve the JSON representation of any Arvados object (collections, projects, etc.) using its UUID.
- **Command**: `arv get <uuid>`
- **Usage**: Useful for inspecting the `manifest_text` of a collection or checking the `portable_data_hash`.

### Collection Management (arv collection)
List and filter data sets within a project or cluster.
- **List by Size**: `arv collection list --order 'file_size_total desc'`
- **Filtering**: Use `jq` to parse the JSON output for specific fields like `portable_data_hash` or `uuid`.

### Data Copying (arv-copy)
Move resources between different Arvados clusters.
- **Command**: `arv-copy --src <source-cluster> --dst <destination-cluster> <uuid>`
- **Credential Management**: `arv-copy` checks `settings.conf` for cluster credentials if a specific configuration file is not provided.

### Deduplication Analysis (arvados-client)
Arvados uses content-addressing to deduplicate data at the block level.
- **Report**: `arvados-client deduplication-report <uuid1> <uuid2> ...`
- **Insight**: This command compares the "Nominal size" (total size of files) against the "Actual size" (unique blocks stored) to show storage savings.

## Expert Tips and Best Practices
- **Content Addressing**: Always prefer using the Portable Data Hash (PDH) for verifying data integrity, as it is a cryptographic hash of the collection's manifest.
- **Streaming Performance**: Arvados 3.0+ supports a streaming architecture in Keep. When downloading or reading data, the system can send blocks before they are fully read, reducing "time to first byte."
- **Metadata Search**: API text searches ignore identifier columns like UUIDs and PDHs to return more relevant results faster.
- **Project Organization**: Use the `arv` tool to organize collections into projects for better access control and collaboration.



## Subcommands

| Command | Description |
|---------|-------------|
| arv-get | Copy data from Keep to a local file or pipe. |
| arv-keepdocker | Upload or list Docker images in Arvados |
| arv-put | Copy data from the local filesystem to Keep. |

## Reference documentation
- [A Look At Deduplication In Keep](./references/arvados_org_2021_05_11_a_look_at_deduplication_in_Keep.md)
- [Arvados 3.1 Release Highlights](./references/arvados_org_blog.md)
- [Arvados 3.0 Release Highlights](./references/arvados_org_index_1.md)
- [Arvados in Regulated Environments](./references/arvados_org_compliance.md)