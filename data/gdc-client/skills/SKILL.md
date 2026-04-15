---
name: gdc-client
description: The gdc-client is a command-line tool for downloading and uploading large-scale genomic data from the National Cancer Institute's Genomic Data Commons. Use when user asks to download files using UUIDs or manifests, resume interrupted data transfers, or upload files to the GDC.
homepage: https://gdc.cancer.gov/access-data/gdc-data-transfer-tool
metadata:
  docker_image: "quay.io/biocontainers/gdc-client:2.3--pyhdfd78af_1"
---

# gdc-client

## Overview
The `gdc-client` is the primary command-line interface for interacting with the National Cancer Institute's Genomic Data Commons. It is specifically designed to handle high-volume data transfers (often 200-300 GB per file) that would be unreliable via a standard web browser. This skill helps you navigate the tool's core functions: downloading data via UUIDs or manifests, resuming interrupted transfers, and submitting data to the GDC.

## Core Commands

### Downloading Data
The `download` command is the most common use case.

- **Download by UUID**:
  `gdc-client download <UUID1> <UUID2>`
- **Download using a Manifest**:
  Recommended for bulk downloads. Download a manifest file (.txt) from the GDC Data Portal first.
  `gdc-client download -m manifest.txt`
- **Specify Output Directory**:
  `gdc-client download -m manifest.txt -d /path/to/destination`

### Controlled Access
To download "Controlled Access" data (e.g., germline variants, primary BAMs), you must provide an authentication token.

1. Download your GDC authentication token from the GDC Data Portal.
2. Use the `-t` flag:
   `gdc-client download -m manifest.txt -t gdc-user-token.txt`

### Resuming Transfers
The tool automatically supports resuming. If a transfer is interrupted, run the exact same command again in the same directory. The client will check the existing files and resume from where it left off.

### Data Submission
For users with submission permissions:
`gdc-client upload -t token.txt -p <project_id> <file_path>`

## Expert Tips & Best Practices

- **MD5 Verification**: The client automatically performs MD5 checksum validation after a download. If a file fails, it will be marked for redownload.
- **Connection Tuning**: If you are on a high-bandwidth network, you can increase the number of download workers (default is 8):
  `gdc-client download -m manifest.txt -n 16`
- **Directory Structure**: By default, `gdc-client` creates a sub-directory named after the File UUID for every file downloaded. To prevent this and download all files into a single flat directory, use the `--no-directory` flag.
- **Retry Logic**: Use the `--retry-amount` flag if you are experiencing unstable network conditions to increase the number of times the client attempts to reconnect.



## Subcommands

| Command | Description |
|---------|-------------|
| gdc-client | The Genomic Data Commons Command Line Client |
| gdc-client download | Download files from the GDC |
| gdc-client settings | Manage gdc-client settings |
| gdc-client upload | Upload files to the GDC. |

## Reference documentation
- [GDC Data Transfer Tool Overview](./references/gdc_cancer_gov_access-data_gdc-data-transfer-tool.md)