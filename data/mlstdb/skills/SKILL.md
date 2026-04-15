---
name: mlstdb
description: mlstdb manages local MLST databases by automating OAuth2 authentication, downloading curated schemes, and compiling them into BLAST databases. Use when user asks to connect to MLST providers, update local schemes, or purge specific alleles and sequence types from the database.
homepage: https://github.com/himal2007/mlstdb
metadata:
  docker_image: "quay.io/biocontainers/mlstdb:0.2.0--pyh7e72e81_0"
---

# mlstdb

## Overview
The `mlstdb` tool streamlines the maintenance of local MLST databases used by bioinformatic typing tools like `mlst`. It automates the complex process of OAuth2 authentication with major providers (PubMLST and Pasteur), handles the downloading of curated schemes, and automatically compiles them into a functional BLAST database. It is particularly useful for ensuring that genomic typing is performed against the most current allele and profile data available.

## Core Workflows

### 1. Initial Database Connection
Before downloading data, you must authorize the tool to access the APIs. This is a one-time setup per database provider.

- **Connect to PubMLST**: `mlstdb connect --db pubmlst`
- **Connect to Pasteur**: `mlstdb connect --db pasteur`

*Note: These commands will attempt to open a web browser for OAuth authorization.*

### 2. Updating Schemes and BLAST Databases
The `update` command is the primary way to keep your local data current. By default, it uses a curated list of schemes.

- **Standard update**: `mlstdb update`
- **Parallel downloads**: Use `--threads <int>` to speed up the process (e.g., `mlstdb update --threads 8`).
- **Unauthenticated access**: Use `--no-auth` to attempt downloads from public APIs without credentials.
- **Resume interrupted downloads**: Use `--resume` to skip schemes that are already successfully downloaded.

### 3. Purging Contaminated Data
If specific alleles or sequence types are found to be dodgy or contaminated, they can be removed without re-downloading the entire database.

- **Remove a specific ST**: `mlstdb purge --scheme salmonella --st 3`
- **Remove a specific allele**: `mlstdb purge --scheme salmonella --allele aroC:1`
  - *Warning: This also removes any STs that reference this allele.*
- **Remove an entire scheme**: `mlstdb purge --scheme salmonella`
- **Batch purge**: Use a YAML configuration file: `mlstdb purge --config purge_config.yaml`

*Note: The BLAST database is automatically rebuilt after any purge operation.*

## Expert Tips and Best Practices

- **Integration with `mlst`**: After running `mlstdb update`, point the `mlst` tool to the generated files:
  `mlst --blastdb blast/mlst.fa --datadir pubmlst your_assembly.fasta`
- **Backup First**: Always back up your `pubmlst/` or `pasteur/` directories before running `update` or `purge`, as these commands modify local files.
- **Scheme Compatibility**: While `mlstdb` can fetch many schemes, not all are validated for use with the `mlst` tool. Stick to bacterial species for the best results.
- **Parallelization**: When updating a large number of schemes, always use the `--threads` flag to significantly reduce wall-clock time.
- **Force Flag**: Use `--force` with the `purge` command to skip confirmation prompts in automated pipelines.



## Subcommands

| Command | Description |
|---------|-------------|
| mlstdb update | Update MLST schemes and create BLAST database. |
| mlstdb_fetch | This tool downloads MLST scheme information from BIGSdb databases. It will automatically handle authentication and save the results. |

## Reference documentation
- [Main README](./references/github_com_MDU-PHL_mlstdb_blob_main_README.md)
- [Changelog and Version History](./references/github_com_MDU-PHL_mlstdb_blob_main_CHANGELOG.md)
- [Usage: Purge Command](./references/mdu-phl_github_io_mlstdb_usage_purge.md)
- [Usage: Update Command](./references/mdu-phl_github_io_mlstdb_usage_update.md)