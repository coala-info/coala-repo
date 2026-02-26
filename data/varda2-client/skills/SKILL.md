---
name: varda2-client
description: The varda2-client is a command-line interface for interacting with Varda2 servers to manage and query genomic data. Use when user asks to annotate files, submit data, monitor job progress, query SNVs, query MNVs, query sequences, perform stab queries, query sample metadata, query task metadata, or save tables.
homepage: https://github.com/varda/varda2-client
---


# varda2-client

## Overview
The `varda2-client` is a Python-based command-line interface designed to communicate with Varda2 servers. It is primarily used by bioinformaticians to query allele frequencies, annotate genomic files, and manage data submissions within a Varda2 instance. This skill helps you navigate the CLI's subcommands for both data management and complex genomic lookups.

## Installation and Setup
Install the client via Bioconda:
```bash
conda install -c bioconda varda2-client
```

### Server Configuration
Most commands require a target server. You can specify this using the `-s` flag:
```bash
varda2-client -s https://varda2.example.com <command>
```
If the server uses a self-signed certificate, provide the path using `-c`:
```bash
varda2-client -s https://varda2.example.com -c /path/to/cert.pem <command>
```

## Core Workflows

### Data Submission and Annotation
*   **Annotate Files**: Use the `annotate` command to process genomic files. This can include an automatic upload to the server.
*   **Submit**: Use `submit` if you need to register data that has already been transferred or handled outside the standard upload flow.
*   **Monitor**: After submitting a job, use `monitor` to check the progress of server-side tasks.

### Querying Variants
The client provides specialized subcommands for different variant types:
*   **SNV Query**: Query Single Nucleotide Variants.
*   **MNV Query**: Query Multi-Nucleotide Variants.
*   **Sequence Query**: Perform queries based on specific DNA sequences.
*   **Stab Query**: Perform "stab" (point) queries against the database.

### Resource Management
*   **Sample/Task Queries**: Use `sample` or `task` to retrieve metadata about specific entities stored on the server.
*   **Save Tables**: Use the `save` command to export server-side tables to local storage.

## Expert Tips
*   **Authentication**: The client expects an authentication token. Ensure your environment is configured with the necessary credentials (typically via environment variables) before running queries.
*   **Verbose Output**: If a command fails or provides insufficient information, check for a `--verbose` or `-v` flag (supported in recent commits) to see the raw server response.
*   **Protocol Specification**: Always include the protocol (`http://` or `https://`) in the server string to avoid connection ambiguities.

## Reference documentation
- [varda2-client GitHub README](./references/github_com_varda_varda2-client.md)
- [varda2-client Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_varda2-client_overview.md)