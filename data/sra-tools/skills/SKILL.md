---
name: sra-tools
description: The SRA Toolkit is the standard suite of utilities for interacting with the International Nucleotide Sequence Database Collaboration (INSDC) Sequence Read Archives.
homepage: https://github.com/ncbi/sra-tools
---

# sra-tools

## Overview

The SRA Toolkit is the standard suite of utilities for interacting with the International Nucleotide Sequence Database Collaboration (INSDC) Sequence Read Archives. It allows researchers to download compressed sequence data and convert it into usable formats like FASTQ, SAM, or SRA-lite. This skill should be used when an agent needs to perform bioinformatic data retrieval, verify the integrity of downloaded runs, or troubleshoot configuration issues related to NCBI data access.

## Core CLI Workflows

### 1. Configuration
Before using the toolkit, ensure the environment is configured, especially for cloud data access (AWS/GCP) or specific download directories.
- **Interactive Configuration**: `vdb-config -i`
- **Report Cloud Identity**: `vdb-config --cloud-report` (useful for verifying AWS/GCP credentials)
- **Set Default Download Path**: Use the interactive menu to set the "Public Repository" path.

### 2. Downloading Data (prefetch)
Always use `prefetch` before attempting to extract data. It is more robust than downloading on-the-fly during extraction.
- **Basic Download**: `prefetch SRR1234567`
- **Download a List**: `prefetch --option-file accessions.txt`
- **SRA Lite**: Use `prefetch --eliminate-quals` to download smaller SRA Lite files when full quality scores are not required.

### 3. Extracting FASTQ (fasterq-dump)
`fasterq-dump` is the modern, multi-threaded replacement for the older `fastq-dump`.
- **Standard Extraction**: `fasterq-dump SRR1234567`
- **Paired-end Data**: `fasterq-dump --split-files SRR1234567` (produces `_1.fastq` and `_2.fastq`)
- **Include Technical Reads**: `fasterq-dump --include-technical SRR1234567` (automatically switches to `--split-files` mode)
- **Specify Threads**: `fasterq-dump -e 8 SRR1234567` (uses 8 threads)

### 4. Validation and Statistics
- **Check Integrity**: `vdb-validate SRR1234567` (reports if data or checksums are missing)
- **View Metadata/Stats**: `sra-stat --xml SRR1234567`

## Expert Tips and Best Practices

- **Avoid fastq-dump**: Unless specifically required for legacy reasons, always prefer `fasterq-dump` for significantly better performance and disk I/O handling.
- **Disk Space**: `fasterq-dump` requires significant temporary disk space (roughly 3x the size of the final FASTQ). Use the `-t` or `--temp` flag to point to a high-capacity scratch directory if the default `/tmp` is too small.
- **Cloud Access**: If working on AWS or GCP, ensure `vdb-config` is set to allow cloud access to avoid egress charges and utilize internal network speeds.
- **Network Errors**: If `prefetch` fails with HTTP errors, check the `phid` (Process Hierarchy ID) in the error message; this is required for NCBI help desk diagnostics.
- **Long Reads**: Version 3.3.0+ supports reads longer than 65K in `fasterq-dump`, making it suitable for modern PacBio and Oxford Nanopore datasets.

## Reference documentation
- [SRA Tools GitHub Overview](./references/github_com_ncbi_sra-tools.md)
- [SRA Tools Wiki Home](./references/github_com_ncbi_sra-tools_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_sra-tools_overview.md)