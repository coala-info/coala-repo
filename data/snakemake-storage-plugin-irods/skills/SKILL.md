---
name: snakemake-storage-plugin-irods
description: This plugin enables Snakemake to use iRODS as a storage backend for automated data transfer and management. Use when user asks to access data using iRODS URIs, configure iRODS as a default storage provider, or integrate iRODS authentication into Snakemake workflows.
homepage: https://github.com/snakemake/snakemake-storage-plugin-irods
---


# snakemake-storage-plugin-irods

## Overview
The snakemake-storage-plugin-irods is a specialized extension for Snakemake that allows the workflow engine to communicate directly with iRODS servers. By using this plugin, you can define input and output files using iRODS URIs, enabling the automated download of dependencies and upload of results to a centralized data management system. It handles the complexities of iRODS authentication and data transfer protocols, including support for secure SSL/TLS connections.

## Installation
Install the plugin via Conda from the Bioconda channel:
```bash
conda install -c bioconda snakemake-storage-plugin-irods
```

## Core Usage Patterns

### URI-Based Data Access
Reference iRODS data objects directly in your Snakefile using the `irods://` protocol:
```python
rule example:
    input:
        "irods://zone/home/user/input.txt"
    output:
        "irods://zone/home/user/output.txt"
    shell:
        "cp {input} {output}"
```

### Global Storage Configuration
To set iRODS as the default storage provider for all files not explicitly prefixed with a protocol, use the following CLI flag:
```bash
snakemake --default-storage-provider irods --storage-irods-host <host> --storage-irods-port <port>
```

## Authentication and Configuration

### Environment Variable Priority
The plugin is designed to prioritize standard iRODS environment settings (e.g., those found in `~/.irods/irods_environment.json`). Ensure your environment is initialized using `iinit` before running Snakemake to leverage existing sessions.

### Password Handling
The plugin supports falling back on scrambled passwords if a plain-text password is not provided, maintaining compatibility with standard iRODS security practices.

### SSL/TLS Support
For secure environments, ensure SSL/TLS is configured. The plugin supports encrypted transfers to protect data in transit between the Snakemake execution node and the iRODS provider.

## Expert Tips
- **Interface Compatibility**: Ensure you are using a version of the plugin compatible with your Snakemake version (v0.3.1+ is adapted for recent storage plugin interface changes).
- **Backend Awareness**: Recent versions have transitioned to using `iBridges` as the backend for improved performance and reliability over the older Python iRODS Client (PRC).
- **Timestamp Handling**: The plugin automatically converts iRODS datetime metadata to Unix timestamps to ensure Snakemake's file-modification-time (mtime) logic functions correctly for determining rule execution.

## Reference documentation
- [snakemake-storage-plugin-irods - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_snakemake-storage-plugin-irods_overview.md)
- [GitHub - snakemake/snakemake-storage-plugin-irods](./references/github_com_snakemake_snakemake-storage-plugin-irods.md)
- [Tags · snakemake/snakemake-storage-plugin-irods](./references/github_com_snakemake_snakemake-storage-plugin-irods_tags.md)