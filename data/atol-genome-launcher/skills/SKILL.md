---
name: atol-genome-launcher
description: The atol-genome-launcher automates the lifecycle of genomic assembly workflows by managing directory structures, data transfers, and pipeline deployments. Use when user asks to deploy assembly pipelines, download sequencing reads from BioPlatforms Australia, or upload assembly results to S3 storage.
homepage: https://github.com/TomHarrop/atol-genome-launcher
---


# atol-genome-launcher

## Overview
The atol-genome-launcher is a specialized toolkit designed to automate the lifecycle of genomic assembly workflows. It provides a standardized interface for parsing assembly manifests, managing directory structures for different processing stages (raw, QC, assembly), and handling data transfer between local environments and remote repositories. It is primarily used by bioinformaticians to initialize run directories, fetch sequencing reads, and archive final assembly outputs using consistent metadata.

## CLI Usage and Commands

### Pipeline Deployment
Use `deploy-pipeline` to initialize a working directory for a specific assembly. This command sets up the necessary Snakemake workflow files and configurations.
- **Basic Deployment**: `deploy-pipeline manifest.yaml`
- **Specify Run Directory**: `deploy-pipeline --run-dir ./my_assembly_run manifest.yaml`
- **Force Update**: Use `--force` to overwrite existing deployment files.

### Data Acquisition
The launcher provides tools to fetch raw reads from BioPlatforms Australia (BPA).
- **Download All Reads**: `assembly-data-downloader manifest.yaml`
- **Parallel Downloads**: Speed up acquisition using `--parallel_downloads <number>`.
- **Single File Download**: `bpa-file-downloader <bioplatforms_url> <destination_file_name>`
  - *Note*: Requires the `BPA_APIKEY` environment variable to be set.

### Result Management and Upload
After pipeline completion, use these tools to archive results to S3-compatible storage (e.g., Ceph).
- **Upload Pipeline Stage**: `pipeline-result-uploader --stage genomeassembly --bucket <my-bucket> manifest.yaml receipts.jsonl`
  - This command walks the output directory, identifies files for the specified stage, and uploads them.
- **Single File Upload**: `result-file-uploader --bucket <my-bucket> <local_file> <remote_path>`

## Environment Configuration
Several commands rely on `rclone` for data transfer. Ensure the following environment variables are configured for upload tasks:
- `RCLONE_CONFIG_UPLOAD_TYPE`: (e.g., "s3")
- `RCLONE_CONFIG_UPLOAD_PROVIDER`: (e.g., "Ceph")
- `RCLONE_CONFIG_UPLOAD_ACCESS_KEY_ID`
- `RCLONE_CONFIG_UPLOAD_SECRET_ACCESS_KEY`
- `RCLONE_CONFIG_UPLOAD_ENDPOINT`

## Best Practices
- **Standardized Manifests**: Always ensure your input manifest follows the AToL `yaml_manifest` schema, as all CLI tools depend on this standardized parsing.
- **Dry Runs**: Use the `-n` flag with downloaders and uploaders to verify file paths and connection settings before initiating large data transfers.
- **Directory Layouts**: The tool uses a `directory_layout.json` to define where "raw" and "qc" files live. Avoid manually moving files out of these expected paths to ensure the `pipeline-result-uploader` can find them.
- **Receipts**: Always provide a `receipts_file` path to `pipeline-result-uploader` to maintain a JSONL log of all successful uploads and their checksums.



## Subcommands

| Command | Description |
|---------|-------------|
| bpa-file-downloader | Downloads files from a given URL and saves them with a specified name. |
| rnaseq-manifest-generator | Generate a manifest of RNAseq data for an organism. |
| rnaseq-reads-downloader | Downloads RNA-Seq reads based on a manifest file. |

## Reference documentation
- [AToL Genome Launcher README](./references/github_com_TomHarrop_atol-genome-launcher_blob_main_README.md)
- [Project Configuration and Scripts](./references/github_com_TomHarrop_atol-genome-launcher_blob_main_pyproject.toml.md)
- [Changelog and Version History](./references/github_com_TomHarrop_atol-genome-launcher_blob_main_CHANGELOG.md)