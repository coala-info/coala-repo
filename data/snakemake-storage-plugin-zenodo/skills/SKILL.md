---
name: snakemake-storage-plugin-zenodo
description: This plugin enables Snakemake to use Zenodo as a remote file system for reading from published records and writing to active depositions. Use when user asks to download files from a Zenodo record, upload results to a Zenodo deposition, or integrate Zenodo storage into a Snakemake workflow.
homepage: https://github.com/snakemake/snakemake-storage-plugin-zenodo
---


# snakemake-storage-plugin-zenodo

## Overview
The Zenodo storage plugin for Snakemake allows researchers to treat Zenodo as a remote file system. This enables automated, reproducible workflows that can pull raw data directly from a persistent DOI-linked record and push processed results back to a Zenodo deposition for long-term storage. It eliminates the need for manual downloads or external upload scripts by integrating Zenodo access directly into the Snakemake file-handling logic.

## Installation
Install the plugin via Conda or Mamba from the Bioconda channel:
```bash
conda install bioconda::snakemake-storage-plugin-zenodo
```

## URI Patterns
The plugin recognizes two distinct URI types based on the state of the Zenodo entry:

### Reading from Published Records
To download files from a published, immutable Zenodo record, use the `record` scheme:
`zenodo://record/<RECORD_ID>/<PATH_TO_FILE>`

Example:
`zenodo://record/121246/data/samples.csv`

### Writing to Active Depositions
To upload files to an existing, unpublished (and therefore writable) deposition, use the `deposition` scheme:
`zenodo://deposition/<DEPOSITION_ID>/<PATH_TO_FILE>`

Example:
`zenodo://deposition/121246/results/final_report.pdf`

## Command Line Integration
When running Snakemake, you can reference these URIs directly within your workflow rules. For global storage settings, use the following CLI patterns:

### Setting a Default Storage Provider
To route all non-local files through Zenodo by default:
```bash
snakemake --default-storage-provider zenodo --default-storage-prefix zenodo://record/<RECORD_ID>
```

### Authentication
While reading public records typically does not require credentials, uploading to a deposition requires a Zenodo API token. Ensure your environment is configured with the necessary access tokens as required by the Snakemake storage plugin interface (typically via environment variables like `ZENODO_TOKEN`).

## Best Practices
- **Record vs. Deposition**: Always use `record://` for inputs to ensure you are pulling from a versioned, immutable source. Use `deposition://` only for outputs intended for a specific, pre-created deposition container.
- **Path Consistency**: Ensure the `<PATH_TO_FILE>` in the URI matches the internal file structure of the Zenodo record or deposition exactly.
- **Rate Limiting**: Be aware that Zenodo employs rate limiting. For workflows with thousands of small files, consider archiving them into a single compressed file before uploading to Zenodo to avoid connection overhead and limit issues.

## Reference documentation
- [Snakemake storage plugin: zenodo](./references/github_com_snakemake_snakemake-storage-plugin-zenodo.md)
- [snakemake-storage-plugin-zenodo - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_snakemake-storage-plugin-zenodo_overview.md)