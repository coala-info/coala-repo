---
name: kingfisher
description: Kingfisher is a utility designed to download and extract public sequencing data and metadata from various repositories like ENA and SRA. Use when user asks to download sequence data by accession or BioProject, extract SRA files into FASTQ format, or retrieve sample metadata.
homepage: https://github.com/wwood/kingfisher-download
metadata:
  docker_image: "quay.io/biocontainers/kingfisher:0.4.1--pyh7cba7a3_0"
---

# kingfisher

## Overview
Kingfisher is a high-performance utility designed to streamline the procurement of public sequencing data. It acts as a flexible wrapper and downloader that can fetch data from multiple mirrors (ENA, SRA, AWS, GCP) and handle the extraction of compressed formats into usable sequence files. Use this skill to automate the retrieval of raw reads and metadata without manually navigating various database interfaces or dealing with complex API calls for each provider.

## Core Workflows

### 1. Downloading Data (`get`)
The `get` command is the primary method for retrieving sequence data. It automatically attempts to find the most efficient source (e.g., ENA via Aspera or FTP) before falling back to others.

*   **Download by Run Accession:**
    `kingfisher get -r ERR1234567 -m ena-ascp`
*   **Download by BioProject:**
    `kingfisher get -p PRJNA621514`
*   **Specify Download Method:** Use `-m` to force a specific protocol:
    *   `ena-ascp`: ENA via Aspera (fastest).
    *   `ena-ftp`: ENA via FTP.
    *   `sra-lite`: NCBI SRA Lite.
    *   `aws-http`: Amazon Web Services.

### 2. Extracting Sequences (`extract`)
If you have downloaded SRA files or need to convert raw data into FASTQ/FASTA format, use the `extract` command.

*   **Basic Extraction:**
    `kingfisher extract -r ERR1234567 --fpath /path/to/file.sra -f fastq`
*   **Paired-end Handling:** Kingfisher automatically handles paired-end data, typically producing `_1.fastq` and `_2.fastq` files.

### 3. Retrieving Metadata (`annotate`)
To get information about the samples (e.g., library strategy, instrument model, organism), use the `annotate` command.

*   **Fetch Metadata:**
    `kingfisher annotate -r ERR1234567 -o metadata.csv`

## Expert Tips and Best Practices

*   **Prioritize ENA-ASCP:** For the fastest downloads, ensure Aspera Connect is installed and use `-m ena-ascp`. It significantly outperforms standard FTP or HTTP downloads.
*   **Batch Processing:** You can provide multiple accessions separated by spaces or use a file containing a list of accessions to process them in a single command.
*   **Check Disk Space:** Sequencing data is voluminous. Always verify available storage before starting a large BioProject download.
*   **Dry Runs:** Use the `--dry-run` flag to see which URLs Kingfisher would attempt to download from without actually initiating the transfer.
*   **Output Organization:** Use the `--output-directory` or `-fpath` arguments to keep your workspace organized, especially when downloading hundreds of runs from a single project.



## Subcommands

| Command | Description |
|---------|-------------|
| kingfisher | kingfisher: error: argument subparser_name: invalid choice: 'compressed' (choose from 'get', 'extract', 'annotate') |
| kingfisher | kingfisher: error: argument subparser_name: invalid choice: 'sequenced' (choose from 'get', 'extract', 'annotate') |
| kingfisher get | Download data from ENA or SRA. |
| kingfisher_annotate | Annotate runs by their metadata e.g. number of sequenced bases, BioSample attributes, etc. |
| kingfisher_extract | Extract .sra format files into FASTQ or FASTA format, compressed or uncompressed. |

## Reference documentation
- [Kingfisher Get Usage](./references/wwood_github_io_kingfisher-download_usage_get.md)
- [Kingfisher Extract Usage](./references/wwood_github_io_kingfisher-download_usage_extract.md)
- [Kingfisher Annotate Usage](./references/wwood_github_io_kingfisher-download_usage_annotate.md)
- [Kingfisher README](./references/github_com_wwood_kingfisher-download_blob_main_README.md)