---
name: pyega3
description: pyEGA3 is a Python client for securely accessing and downloading authorized genomic datasets from the European Genome-phenome Archive. Use when user asks to list authorized datasets, list files within a dataset, or download specific files and datasets using credentials.
homepage: https://github.com/EGA-archive/ega-download-client
metadata:
  docker_image: "quay.io/biocontainers/pyega3:5.2.0--pyhdfd78af_0"
---

# pyega3

## Overview

pyEGA3 is the official Python-based client for the EGA Data API, designed for secure and efficient access to authorized genomic datasets. It handles the complexities of the EGA's secure API, providing features like resumable downloads, parallelized file segmenting, and automatic checksum verification. Use this skill to navigate the EGA repository, manage authentication via JSON credential files, and execute high-performance data fetches for both individual files and entire datasets.

## Credential Management

To access authorized data, you must provide a JSON credentials file.

1.  **Create the file** (e.g., `credentials.json`):
    ```json
    {
        "username": "your_ega_email@example.com",
        "password": "your_password"
    }
    ```
2.  **Reference the file** in every command using the `-cf` flag.

## Common CLI Patterns

### Exploration
*   **List authorized datasets**:
    `pyega3 -cf credentials.json datasets`
*   **List files within a specific dataset**:
    `pyega3 -cf credentials.json files <DATASET_ID>` (e.g., EGAD00001003338)

### Data Retrieval
*   **Download a single file**:
    `pyega3 -cf credentials.json fetch <FILE_ID>` (e.g., EGAF00001775036)
*   **Download an entire dataset**:
    `pyega3 -cf credentials.json fetch <DATASET_ID>`

### Testing and Debugging
*   **Test installation (no credentials required)**:
    `pyega3 -d -t datasets`
*   **Enable verbose logging**:
    Add the `-d` (debug) flag before the subcommand.

## Performance Optimization

For large genomic files, use these flags to improve throughput:

*   **Parallel Connections**: Use `-c` to specify the number of concurrent connections (default is 1).
    `pyega3 -cf credentials.json -c 10 fetch <FILE_ID>`
*   **Slice Size**: Use `-ms` to adjust the maximum size for each segment in bytes (default is 100 MB).
    `pyega3 -cf credentials.json -ms 209715200 fetch <FILE_ID>` (sets slice to 200MB)

## Expert Tips

*   **Resumability**: pyEGA3 automatically resumes interrupted downloads. Do not delete the temporary files created during the process if you intend to resume.
*   **Integrity**: The tool performs checksum verification automatically after the download completes. If a download finishes but the checksum fails, check the debug logs (`-d`).
*   **Genomic Ranges**: pyEGA3 supports the htsget protocol for downloading specific genomic ranges if the data file has an accompanying index.



## Subcommands

| Command | Description |
|---------|-------------|
| pyega3 | pyega3: error: argument subcommand: invalid choice: 'Download' (choose from 'datasets', 'files', 'fetch') |
| pyega3 | pyega3: error: argument subcommand: invalid choice: 'JSON' (choose from 'datasets', 'files', 'fetch') |
| pyega3 | pyega3: error: argument subcommand: invalid choice: 'this' (choose from 'datasets', 'files', 'fetch') |
| pyega3 fetch | Fetch data from EGA. |
| pyega3 files | List files in a dataset |

## Reference documentation
- [EGA Download Client README](./references/github_com_EGA-archive_ega-download-client_blob_master_README.md)
- [Default Credential Format](./references/github_com_EGA-archive_ega-download-client_blob_master_pyega3_config_default_credential_file.json.md)