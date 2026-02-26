---
name: iseq
description: iseq is a utility designed to retrieve and download genomic data from international sequence databases like SRA, ENA, and DDBJ. Use when user asks to download sequencing data, retrieve metadata from genomic repositories, or automate batch downloads of FASTQ files.
homepage: https://github.com/BioOmics/iSeq
---


# iseq

## Overview

iSeq is a specialized utility designed to streamline the retrieval of genomic data from international sequence databases. It abstracts the complexity of interacting with different repository APIs (GSA, SRA, ENA, DDBJ, GEO) into a single command-line interface. It is particularly useful for bioinformaticians needing to automate the download of large-scale datasets, offering features like automatic retries, file integrity verification, and multi-threaded processing.

## Installation

Install via Bioconda for the most stable environment:

```bash
conda install -c bioconda iseq
```

## Common CLI Patterns

### Basic Data Retrieval
Download all sequencing data and metadata associated with a specific project or run:
```bash
iseq -i PRJNA211801
```

### High-Speed Batch Downloads
For large datasets, use a text file containing multiple accessions and enable Aspera acceleration (`-a`) and direct gzip FASTQ download (`-g`):
```bash
iseq -i accession_list.txt -a -g
```

### Merging and Organization
Merge multiple FASTQ files into a single file per experiment, sample, or study using the `-e` flag:
```bash
# Merge by Experiment
iseq -i SRR7706354 -e ex

# Merge by Sample
iseq -i SRR7706354 -e sa
```

### Resource Management
Limit download speed to prevent network congestion or specify an output directory:
```bash
iseq -i SRR7706354 -s 10 -o ./my_data_dir
```

## Expert Tips

- **Aspera Acceleration**: Always use the `-a` flag when downloading from ENA or GSA if your environment supports it; it is significantly faster than standard HTTP/FTP.
- **Direct FASTQ**: Use the `-g` flag to download gzip-formatted FASTQ files directly. This avoids the time-consuming step of downloading SRA files and then converting them via `fastq-dump`.
- **Clean Logging**: When running iseq in a CI/CD pipeline or HPC cluster, use the `-Q` (quiet) option to suppress progress bars and keep your log files readable.
- **Error Handling**: If a batch download fails, iseq will generate a `fail.log`. You can use this log to identify specific accessions that need to be retried.
- **MD5 Verification**: By default, iseq verifies file integrity. If you are working with a local mirror or have already verified files, use `-k` to skip MD5 checks and save time.
- **Database Switching**: If ENA is inaccessible, iseq can automatically attempt to switch databases, but you can force a specific database if you know the source of the accession.

## Reference documentation

- [iSeq GitHub Repository](./references/github_com_BioOmics_iSeq.md)
- [iSeq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_iseq_overview.md)