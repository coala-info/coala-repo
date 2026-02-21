---
name: snakemake-executor-plugin-tes
description: The `snakemake-executor-plugin-tes` is a specialized plugin for Snakemake 8+ that allows workflow tasks to be offloaded to any infrastructure implementing the GA4GH Task Execution Service (TES) API.
homepage: https://github.com/snakemake/snakemake-executor-plugin-tes
---

# snakemake-executor-plugin-tes

## Overview
The `snakemake-executor-plugin-tes` is a specialized plugin for Snakemake 8+ that allows workflow tasks to be offloaded to any infrastructure implementing the GA4GH Task Execution Service (TES) API. This plugin is essential for users operating in cloud-native environments or distributed systems where a centralized task manager handles scheduling, resource allocation, and container execution. It translates Snakemake's internal job representations into TES-compatible JSON requests, managing the lifecycle of the task from submission to completion.

## Installation
The plugin must be installed in the same environment as Snakemake:

```bash
conda install -c bioconda snakemake-executor-plugin-tes
```
Or via pip:
```bash
pip install snakemake-executor-plugin-tes
```

## Command Line Usage
To activate the plugin, use the `--executor` flag. The most critical parameter is the TES server URL.

### Basic Execution
Submit jobs to a local or remote TES server:
```bash
snakemake --executor tes --tes-url http://localhost:8000
```

### Authenticated Submission
If the TES endpoint is secured with basic authentication:
```bash
snakemake --executor tes --tes-url <url> --tes-user <username> --tes-password <password>
```

## Expert Tips and Best Practices

### Container Requirements
Most TES implementations (like Funnel) require a container image to run a task. Ensure your Snakemake rules include a `container:` directive, or provide a default container via the CLI:
```bash
snakemake --executor tes --tes-url <url> --default-container ubuntu:latest
```

### Resource Management
Snakemake rule resources are mapped directly to TES resource requests. Define these in your Snakefile to ensure the TES scheduler allocates appropriate hardware:
- `threads`: Mapped to `cpu_cores`.
- `resources: mem_mb=X`: Mapped to `ram_gb`.
- `resources: disk_mb=X`: Mapped to `disk_gb`.

### Data Handling and Storage
TES typically expects data to be available via URLs (HTTP, S3, GS, etc.) unless a shared filesystem is explicitly configured.
- **Remote Files**: Use Snakemake's storage plugins (e.g., `snakemake-storage-plugin-s3`) in conjunction with the TES executor to ensure workers can pull inputs and push outputs.
- **Shared FS**: If the TES workers and the Snakemake head node share a filesystem, ensure the paths are consistent across all nodes.

### Troubleshooting
If jobs fail immediately, check the following:
1. **Endpoint Reachability**: Ensure the machine running Snakemake can reach the `--tes-url`.
2. **API Version**: This plugin is designed for GA4GH TES compliance. Verify your server (e.g., Funnel) is running a compatible version.
3. **Logs**: Use `snakemake --executor tes --tes-url <url> --verbose` to see the raw task JSON being sent to the server.

## Reference documentation
- [Snakemake TES Plugin Overview](./references/anaconda_org_channels_bioconda_packages_snakemake-executor-plugin-tes_overview.md)
- [GitHub Repository](./references/github_com_snakemake_snakemake-executor-plugin-tes.md)