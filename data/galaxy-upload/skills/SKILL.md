---
name: galaxy-upload
description: The galaxy-upload utility provides a command-line interface for transferring data and large datasets to Galaxy servers. Use when user asks to upload files to a Galaxy history, perform resumable data transfers, or search for history IDs from the terminal.
homepage: https://github.com/galaxyproject/galaxy-upload
---


# galaxy-upload

## Overview

The `galaxy-upload` utility provides a robust command-line interface for transferring data to Galaxy servers. It is designed to replace or augment the web-based upload tool, making it ideal for large datasets, high-latency connections, or integration into local shell scripts. It natively supports the tus protocol for resumable uploads and includes a helper utility, `galaxy-history-search`, to identify target histories without leaving the terminal.

## Core Configuration

To ensure security and reduce command length, define your Galaxy credentials as environment variables in your shell profile (e.g., `.bashrc` or `.zshrc`):

```bash
export GALAXY_URL="https://usegalaxy.org"
export GALAXY_API_KEY="your_api_key_here"
```

## Target History Selection

You must specify a target history using either its name or its unique encoded ID.

### Searching for Histories
Use `galaxy-history-search` to find the correct ID or verify a name. It supports regular expressions and case-insensitive matching.

*   **Case-insensitive search**: `galaxy-history-search --ignore-case "project_name"`
*   **Regex search (ends with)**: `galaxy-history-search "trinity$"`

### Handling Name Collisions
If `--history-name` matches multiple histories, the tool will error and list the matches. In these cases, you must use the `--history-id` flag with the specific ID found via the search utility.

## Upload Patterns

### Basic Batch Upload
Upload multiple files to a specific history name:
`galaxy-upload --history-name "My Analysis" file1.fastq.gz file2.fastq.gz`

### Resumable Uploads (Expert Tip)
For large files or unstable connections, use the `--storage` flag. This creates a state file that tracks progress. If the transfer is interrupted, running the exact same command will resume from the last successful chunk.

`galaxy-upload --history-id <ID> --storage upload_state.txt large_dataset.bam`

### Metadata and Formatting
Mirror Galaxy UI options directly in the CLI:
*   **Set File Type**: `--file-type fastqsanger.gz`
*   **Set Genome/Dbkey**: `--dbkey hg38`
*   **Rename on Upload**: Use `--file-name "New_Name.bam"` (Note: only works for single file uploads).
*   **Format Manipulation**: Use `--space-to-tab` to convert spaces to tabs during the upload process.

## Troubleshooting

*   **URL Parsing**: Ensure the `--url` includes the protocol (https://). Some versions may be sensitive to trailing slashes.
*   **API Key**: Your API key is found in the Galaxy UI under **User > Preferences > Manage API Key**.
*   **Server Version**: This tool requires Galaxy 22.01 or later to support the tus protocol.

## Reference documentation
- [Galaxy Upload Utility for the CLI](./references/github_com_galaxyproject_galaxy-upload.md)
- [galaxy-upload - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_galaxy-upload_overview.md)