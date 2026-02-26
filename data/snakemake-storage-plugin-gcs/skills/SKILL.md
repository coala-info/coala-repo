---
name: snakemake-storage-plugin-gcs
description: This plugin enables Snakemake to use Google Cloud Storage as a storage layer for workflow inputs and outputs. Use when user asks to interface Snakemake with GCS buckets, configure cloud storage URIs, or run workflows using Google Cloud Storage as the default storage provider.
homepage: https://github.com/snakemake/snakemake-storage-plugin-gcs
---


# snakemake-storage-plugin-gcs

## Overview
The snakemake-storage-plugin-gcs allows Snakemake to seamlessly interface with Google Cloud Storage. By using this plugin, you can treat GCS buckets as a primary storage layer for workflow inputs and outputs, which is essential for running large-scale bioinformatics or data science pipelines in cloud environments. It handles the complexities of uploading, downloading, and tracking file metadata within the Google Cloud ecosystem.

## Installation
Install the plugin via Conda from the Bioconda channel:
```bash
conda install -c bioconda snakemake-storage-plugin-gcs
```

## URI Configuration
The plugin supports two URI schemes for identifying files in Google Cloud Storage:
- `gs://bucket/path/to/file` (Standard Google Cloud scheme)
- `gcs://bucket/path/to/file` (Plugin-specific alias)

**Expert Tip**: While both schemes are supported, the plugin internally normalizes `gcs://` to `gs://` to ensure maximum compatibility with other Google Cloud SDK tools and libraries. It is generally recommended to use `gs://` in your Snakefiles for consistency across the GCP ecosystem.

## CLI Usage Patterns
To enable GCS storage globally for a workflow execution, use the following CLI flags:

### Basic Cloud Execution
```bash
snakemake --default-storage-provider gcs \
          --default-storage-prefix gs://your-bucket-name/project-folder \
          --jobs 10
```

### Handling Directories
When working with directory outputs in GCS, ensure your Snakefile uses the `directory()` wrapper. The plugin handles the recursive upload/download of directory contents to the specified GCS prefix.

### Testing with Local Mock
For local development and testing without incurring cloud costs, you can point the plugin to a local GCS mock server (like `fake-gcs-server`):
```bash
# Example pattern for testing against a local mock
export STORAGE_GCS_ENDPOINT_URL="http://localhost:8080"
snakemake --default-storage-provider gcs ...
```

## Best Practices and Troubleshooting
- **Authentication**: The plugin typically relies on Application Default Credentials (ADC). Ensure you have run `gcloud auth application-default login` or set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable.
- **Avoid Redundant Flags**: Note that the `--keep-local` option was removed in recent versions (v1.1.3+) as it became redundant with the core Snakemake storage management logic.
- **Input/Output Conversion**: If you encounter a `MissingInputException` when a rule's output is used as another rule's input in a cloud context, verify that the storage prefix is correctly configured and that the bucket permissions allow for immediate consistency in file listing.
- **Large Scale Workflows**: For workflows involving thousands of files, be aware that the plugin performs individual file checking. Monitor your API request quotas in the Google Cloud Console if you experience latency during the "Building DAG" phase.

## Reference documentation
- [Snakemake GCS Plugin Overview](./references/anaconda_org_channels_bioconda_packages_snakemake-storage-plugin-gcs_overview.md)
- [GitHub Repository and README](./references/github_com_snakemake_snakemake-storage-plugin-gcs.md)
- [Version Tags and Release Notes](./references/github_com_snakemake_snakemake-storage-plugin-gcs_tags.md)