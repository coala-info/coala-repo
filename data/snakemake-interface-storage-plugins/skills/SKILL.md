---
name: snakemake-interface-storage-plugins
description: The `snakemake-interface-storage-plugins` package acts as the formal bridge between the Snakemake workflow engine and various storage backends (e.g., S3, HTTP, Google Cloud Storage).
homepage: https://github.com/snakemake/snakemake-interface-storage-plugins
---

# snakemake-interface-storage-plugins

## Overview

The `snakemake-interface-storage-plugins` package acts as the formal bridge between the Snakemake workflow engine and various storage backends (e.g., S3, HTTP, Google Cloud Storage). This skill guides the implementation of the required Python classes—`StorageProvider` and `StorageObject`—to ensure compatibility with Snakemake's execution environment. It is essential for developers creating new plugins or for users needing to understand how plugin-specific parameters are exposed through the Snakemake command-line interface.

## Implementation Patterns

### 1. Setting Up the Plugin Skeleton
The recommended way to start a new storage plugin is using `snakedeploy`. This automates the creation of the package structure and testing environment.

### 2. Defining Plugin Settings
Settings defined in your plugin are automatically exposed to the Snakemake CLI.
- **CLI Mapping**: A field named `myparam` in a plugin named `mycloud` becomes `--storage-mycloud-myparam`.
- **Environment Variables**: If `env_var=True` is set in the metadata, it maps to `SNAKEMAKE_MYCLOUD_MYPARAM`.
- **Best Practice**: Use `Optional` types with a default of `None` for all settings fields.

### 3. Storage Provider Implementation
The `StorageProvider` class manages global state, connection pools, and query validation.
- **Initialization**: Do not overwrite `__init__`. Use `__post_init__(self)` to set up backend connections.
- **Rate Limiting**: Implement `rate_limiter_key` to identify unique endpoints (e.g., a host name for HTTP) to prevent throttling.
- **Query Validation**: Use `is_valid_query` to check if a string matches your storage schema. Ensure it handles Snakemake wildcards (e.g., `{sample}`) as these are resolved before the storage object is instantiated.

### 4. Storage Object Implementation
The `StorageObject` class handles the actual data operations. Inherit only from the mixins your backend supports:
- `StorageObjectRead`: For downloading/reading.
- `StorageObjectWrite`: For uploading/writing.
- `StorageObjectGlob`: For pattern matching/listing.
- `StorageObjectTouch`: For updating timestamps.

### 5. Performance Optimization
- **Inventory**: Implement the `async def inventory` method to pre-fetch existence and modification date information. This reduces the number of API calls during the workflow's dry-run and initialization phases.
- **On-Demand Eligibility**: Use the `is_ondemand_eligible` attribute to inform Snakemake if an object can be lazily mounted or symlinked instead of being fully downloaded.

## Common CLI Patterns

When using a storage plugin within a Snakemake workflow, parameters are passed directly through the main `snakemake` command:

```bash
snakemake --storage-<plugin>-<setting> <value>
```

For sensitive credentials, prefer environment variables:

```bash
export SNAKEMAKE_<PLUGIN>_<SETTING>=<value>
snakemake --use-conda
```

## Expert Tips
- **Sensitive Data**: Use the `safe_print` method in your `StorageProvider` to scrub tokens or passwords from queries before they are written to Snakemake logs.
- **Retries**: Use the `retry_decorator` provided by the interface for fragile network operations to improve plugin robustness.
- **Tagging**: Snakemake allows storage settings to be tagged (e.g., `tagname:value`). This allows a single workflow to use the same storage plugin with different configurations for different rules.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_snakemake_snakemake-interface-storage-plugins.md)
- [Anaconda Package Details](./references/anaconda_org_channels_bioconda_packages_snakemake-interface-storage-plugins_overview.md)