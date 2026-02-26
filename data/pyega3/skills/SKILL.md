---
name: pyega3
description: The pyega3 tool provides a command-line interface for securely downloading genomic datasets and files from the European Genome-phenome Archive. Use when user asks to list authorized datasets, download specific files or entire datasets, or retrieve genomic range slices using the htsget protocol.
homepage: https://github.com/EGA-archive/ega-download-client
---


# pyega3

## Overview

The `pyega3` skill provides a specialized interface for the official European Genome-phenome Archive (EGA) Python download client. This tool is designed to handle the complexities of genomic data distribution, offering secure HTTPS transfers, automatic download resumption, and parallelized file segmenting to maximize bandwidth. It also ensures data integrity by performing checksum verification post-download and supports the GA4GH-compliant htsget protocol for targeted genomic range retrieval.

## Authentication

To access private datasets, you must provide credentials in a JSON file.

**Credentials Format (`credentials.json`):**
```json
{"username": "your_ega_email", "password": "your_password"}
```

**Usage:**
Pass the file using the `-cf` or `--config-file` flag in your commands.

## Common CLI Patterns

### Exploration
*   **List authorized datasets:**
    `pyega3 -cf credentials.json datasets`
*   **List files within a specific dataset:**
    `pyega3 -cf credentials.json files EGAD0000XXXXXXXX`

### Downloading Data
*   **Download a single file:**
    `pyega3 -cf credentials.json fetch EGAF0000XXXXXXXX --output-dir ./downloads`
*   **Download an entire dataset:**
    `pyega3 -cf credentials.json fetch EGAD0000XXXXXXXX --output-dir ./downloads`

### Genomic Range Requests (htsget)
For files with accompanying indices, you can download specific slices:
`pyega3 fetch EGAF0000XXXXXXXX --reference-name 22 --start 1000000 --end 2000000 --format BAM --output-dir ./slices`

## Performance Optimization

*   **Parallel Connections:** Use the `-c` flag to specify the number of concurrent connections (default is 1). Increasing this can significantly speed up large downloads.
    `pyega3 -c 5 -cf credentials.json fetch EGAD0000XXXXXXXX`
*   **Slice Size:** Adjust the maximum slice size for downloads using `-ms` (default is 100MB).
    `pyega3 -ms 209715200 -cf credentials.json fetch EGAF0000XXXXXXXX` (Sets slice to 200MB)

## Expert Tips

*   **Testing Connectivity:** Use the `-t` flag to run commands against a public test account (1000 Genomes Project data). This is useful for verifying your installation and network environment without needing EGA credentials.
    `pyega3 -d -t datasets`
*   **Integrity Checks:** `pyega3` automatically verifies MD5 checksums. If a download is interrupted, simply run the same command again; the client will resume from the last successful segment.
*   **Debugging:** Use the `-d` flag to enable verbose debug logging if you encounter connection issues or authentication failures.
*   **Background Execution:** For large datasets, use `nohup` to prevent the process from terminating if your session closes:
    `nohup pyega3 -cf credentials.json fetch EGAD0000XXXXXXXX > download.log 2>&1 &`

## Reference documentation
- [EGA download client: pyEGA3](./references/github_com_EGA-archive_ega-download-client.md)
- [pyega3 - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pyega3_overview.md)