---
name: hca
description: The hca utility provides a command-line interface and Python library for managing and interacting with data in the Human Cell Atlas Data Storage Service. Use when user asks to download data bundles, upload biological files, search for metadata using Elasticsearch queries, or authenticate with the HCA platform.
homepage: https://github.com/HumanCellAtlas/dcp-cli
metadata:
  docker_image: "quay.io/biocontainers/hca:7.0.1--py_0"
---

# hca

## Overview
The `hca` utility (also known as `dcp-cli`) is the official command-line interface and Python library for the Human Cell Atlas. It provides a programmatic way to manage large-scale biological data, allowing users to interface directly with the Data Storage Service (DSS). While the tool is currently deprecated in favor of the HCA Data Browser for general data access, it remains the primary CLI for legacy DSS interactions, automated data ingestion, and specific metadata queries.

## Authentication and Setup
Before performing restricted operations, you must authenticate with the platform.

- **Interactive Login**: Run `hca dss login` to open a browser-based OAuth flow.
- **Service Accounts**: For automated environments, set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable to the path of your service account JSON key.
- **Configuration**: The CLI stores settings in `~/.config/hca/config.json`. You can override this by setting the `HCA_CONFIG_FILE` environment variable.

## Common CLI Patterns

### Data Retrieval
To download data bundles or specific files from the DSS, you must specify the cloud replica (e.g., `aws` or `gcp`).

- **Download a Bundle**:
  `hca dss download --uuid <BUNDLE_UUID> --replica aws`
- **Download via Manifest**:
  `hca dss download-manifest --uuid <MANIFEST_UUID> --replica gcp`
- **Organize by Bundle**: Use the `--layout bundle` flag to ensure downloaded files are organized into subdirectories corresponding to their HCA bundles.

### Data Ingestion
Uploading data typically involves the Upload Service.

- **Upload a Directory**:
  `hca upload select <UPLOAD_AREA_UUID>`
  `hca upload file <LOCAL_PATH>`

### Querying and Discovery
The CLI allows searching the DSS using Elasticsearch DSL queries.

- **Search for Bundles**:
  `hca dss post-search --es-query '{"query": {"match_all": {}}}' --replica aws`

## Expert Tips
- **Array Merge Operators**: When managing configuration files, the CLI supports `tweak` operators (like `+:`) to extend lists in the JSON config rather than overwriting them.
- **Python API**: For complex workflows, the `hca` package can be imported as a Python library (`from hca.dss import DSSClient`), which provides a more robust interface for handling paginated search results.
- **Deprecation Warning**: Always verify if your task can be accomplished via the HCA Data Browser, as the `dcp-cli` is no longer receiving active feature updates.

## Reference documentation
- [HCA DCP CLI Overview](./references/github_com_HumanCellAtlas_dcp-cli.md)
- [Bioconda HCA Package](./references/anaconda_org_channels_bioconda_packages_hca_overview.md)
- [HCA Security Policy](./references/github_com_HumanCellAtlas_dcp-cli_security.md)