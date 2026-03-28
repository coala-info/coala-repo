---
name: varda2-client
description: The varda2-client is a command-line interface for interacting with Varda2 servers to manage and query genomic variant frequency data. Use when user asks to annotate VCF files, submit genomic data, monitor server tasks, or query SNVs, MNVs, and sequences.
homepage: https://github.com/varda/varda2-client
---

# varda2-client

## Overview

The `varda2-client` is a Python-based command-line interface designed to communicate with Varda2 servers. It serves as a bridge for bioinformaticians to manage genomic variant frequency data. The tool supports a full lifecycle of data interaction: from uploading and annotating VCF files to querying specific variants (SNVs, MNVs, or sequences) and exporting results. It is particularly useful for automating workflows that require population-scale frequency lookups or centralized variant management.

## CLI Usage and Best Practices

### Global Configuration
Most commands require a target server. You can specify the server and an optional SSL certificate globally:
- Use `-s <SERVER_HOSTNAME>` to define the Varda2 instance.
- Use `-c <CERTIFICATE_PATH>` if the server uses a self-signed or specific CA certificate.

### Core Workflows

#### 1. Annotation and Submission
To process new genomic data, use the `annotate` command. This is the most common entry point for new datasets.
- **Annotate with Upload**: `varda2-client annotate <file_path>`
- **Submit Only**: If the file is already present on the server or managed elsewhere, use `submit` to initiate processing without a fresh upload.

#### 2. Querying the Database
Varda2 supports several specific query types to retrieve frequency information:
- **SNV Query**: Use `snv` for single nucleotide variants.
- **MNV Query**: Use `mnv` for multi-nucleotide variants.
- **Sequence Query**: Use `seq` to query by genomic sequence.
- **Stab Query**: Use `stab` for structural or specific genomic interval queries.

#### 3. Task Monitoring
Since annotation and large queries are processed asynchronously on the server, use the `monitor` command to track progress.
- Run `varda2-client monitor` to see the status of active and pending tasks.
- Once a task is complete, use `save` to retrieve and store the resulting tables locally.

### Expert Tips
- **Environment Variables**: Ensure your authentication token is set in your environment if the server requires it (typically checked during command execution).
- **Verbosity**: If a command fails or provides insufficient output, check for a `--verbose` flag (supported in recent commits) to debug the server response.
- **Version Check**: Use `varda2-client version` to ensure compatibility between your client and the Varda2 server API.



## Subcommands

| Command | Description |
|---------|-------------|
| varda2-client annotate | Annotate variants with sample information. |
| varda2-client mnv | Finds and reports insertions in a given region. |
| varda2-client monitor | Monitor tasks |
| varda2-client sample | Sample management for Varda2 |
| varda2-client seq | Sequence |
| varda2-client snv | SNV subcommand for varda2-client |
| varda2-client stab | Get stabilized sequence for a given region |
| varda2-client submit | Submit VCF or sample sheet to Varda |
| varda2-client task | (No description) |

## Reference documentation
- [Varda2 Client README](./references/github_com_varda_varda2-client_blob_master_README.md)
- [Varda2 Client Setup and Entry Points](./references/github_com_varda_varda2-client_blob_master_setup.py.md)