---
name: arvados-python-client
description: The Arvados Python Client provides the programmatic interface for Arvados, an open-source platform for managing and analyzing scientific big data.
homepage: https://github.com/curoverse/arvados/tree/main/sdk/python
---

# arvados-python-client

## Overview
The Arvados Python Client provides the programmatic interface for Arvados, an open-source platform for managing and analyzing scientific big data. This skill enables efficient interaction with Arvados services, specifically focusing on data management within the Keep storage system and resource orchestration. Use this tool to automate data uploads, query metadata, and manage collections without manual intervention through the Workbench UI.

## Authentication and Setup
Before using the client, ensure your environment is configured with Arvados API credentials.
- **Environment Variables**: Set `ARVADOS_API_HOST` and `ARVADOS_API_TOKEN`.
- **Insecure Connections**: If using a self-signed certificate, set `ARVADOS_API_HOST_INSECURE=1`.

## Common CLI Patterns
The Python SDK installs several high-utility command-line tools:

### Data Management (Keep)
- **Upload data**: `arv-put path/to/data`
  - Use `--project-uuid` to specify a destination project.
  - Use `--stream` to pipe data directly into a collection.
- **Download data**: `arv-get [collection-uuid-or-portable-data-hash]/filename path/to/local/file`
- **Mount Keep**: `arv-mount /path/to/mountpoint`
  - This exposes Arvados collections as a local filesystem for easy browsing.

### Resource Management
- **Querying objects**: `arv-get [uuid]` returns the JSON representation of any Arvados object (collections, projects, users).
- **Deleting objects**: `arv-keepdocker --delete [image-name]` (specifically for managing Docker images in Keep).

## Python SDK Best Practices

### Initializing the Client
```python
import arvados
api = arvados.api('v1')
```

### Working with Collections
Use the `CollectionReader` and `CollectionWriter` classes for efficient data handling:
- **Reading**: `arvados.collection.CollectionReader("uuid-or-pdh")` allows file-like access to data in Keep.
- **Writing**: `arvados.collection.CollectionWriter()` allows you to build a collection programmatically and commit it to Keep.

### Efficient Searching
When using `api.collections().list()`, always use filters to minimize payload size:
```python
# Example: Find collections by name
results = api.collections().list(
    filters=[["name", "like", "Project-Alpha-%"]]
).execute()
```

## Expert Tips
- **Portable Data Hashes (PDH)**: When referencing data for reproducibility, use the PDH (e.g., `d41d8cd98f00b204e9800998ecf8427e+0`) instead of the UUID. UUIDs point to the container, while PDHs point to the specific content.
- **Batching**: For large metadata operations, use the `num_retries` parameter in `.execute(num_retries=n)` to handle transient network issues.
- **Keep Locators**: Understand that Keep locators often include a hint (e.g., `+K@clusterid`) which is necessary for cross-cluster data access.

## Reference documentation
- [Arvados GitHub Repository](./references/github_com_arvados_arvados.md)
- [Arvados Python SDK Source](./references/github_com_arvados_arvados_tree_main_sdk_python.md)