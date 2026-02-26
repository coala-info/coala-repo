---
name: kingfisher
description: "Kingfisher downloads and extracts genomic read data and metadata from various public repositories using a unified interface. Use when user asks to download sequence data by accession number, extract SRA files to FASTQ format, or retrieve metadata for BioProjects and runs."
homepage: https://github.com/wwood/kingfisher-download
---


# kingfisher

## Overview
Kingfisher is a specialized utility designed to simplify the procurement of genomic read data. It provides a unified command-line interface to fetch data from multiple public backends, abstracting away the complexities of different repository APIs and transfer protocols. Use this skill to automate the retrieval of sequence files and their associated metadata using standard accession numbers.

## Core Workflows

### Downloading Data
The primary command for fetching data is `get`. You must provide either a Run accession (`-r`) or a BioProject/Study accession (`-p`).

*   **Download a single run:** `kingfisher get -r ERR1234567`
*   **Download an entire project:** `kingfisher get -p PRJNA621514`
*   **Specify download method:** Use `-m` to force a specific protocol (e.g., `ena-ascp`, `ena-ftp`, `sra-tools`, `aws-cp`, `gcp-cp`).
*   **Output management:** Use `--output-directory` to define where files should be saved.

### Extracting Sequences
If you have downloaded SRA files or need to convert formats, use the `extract` command.

*   **Extract to FASTQ:** `kingfisher extract -r ERR1234567 --format fastq`
*   **Stream to stdout:** Use the `--stdout` flag to pipe data directly into another tool (e.g., a mapper or quality control tool) without saving large intermediate files.

### Retrieving Metadata
To get information about accessions without downloading the full sequence data, use the `annotate` command.

*   **Fetch annotations:** `kingfisher annotate -r ERR1234567`
*   **Batch metadata:** Kingfisher can accept multiple accessions to generate a summary table of metadata.

## Expert Tips and Best Practices

*   **Method Selection:** If `ena-ascp` (Aspera) is available, it is generally the fastest method for ENA data. If it fails, kingfisher typically falls back to `ena-ftp`.
*   **Disk Space:** Genomic data is large. Always check available space or use the `--stdout` streaming pattern to process data on the fly.
*   **Accession Types:** 
    *   **Run accessions** (starting with SRR, ERR, DRR) refer to specific sequencing experiments.
    *   **BioProject/Study accessions** (starting with PRJ, SRP, ERP) refer to collections of runs.
*   **Verification:** Kingfisher includes internal checks (like `pigz -t`) to verify the integrity of downloaded compressed files. If a download is corrupted, try re-running with a different method (`-m`).

## Reference documentation
- [Kingfisher GitHub Repository](./references/github_com_wwood_kingfisher-download.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_kingfisher_overview.md)