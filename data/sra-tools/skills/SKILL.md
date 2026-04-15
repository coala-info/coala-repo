---
name: sra-tools
description: The SRA Toolkit provides a suite of utilities for downloading and converting sequence data from the NCBI Sequence Read Archive into standard bioinformatics formats. Use when user asks to download SRA accessions, convert SRA files to FASTQ or SAM formats, configure cloud data access, or validate the integrity of downloaded sequence data.
homepage: https://github.com/ncbi/sra-tools
metadata:
  docker_image: "quay.io/biocontainers/sra-tools:3.2.1--h4304569_1"
---

# sra-tools

## Overview

The SRA Toolkit is the essential suite of utilities for interacting with the National Center for Biotechnology Information (NCBI) Sequence Read Archive. This skill should be used to navigate the transition from the SRA's specialized, compressed data format into standard bioinformatics formats like FASTQ and SAM. It covers the modern "prefetch and dump" workflow, which is significantly more reliable and faster than legacy on-the-fly streaming methods.

## Core Workflow: Prefetch and Dump

The recommended way to process SRA data is a two-step process. This avoids network-related crashes during the conversion phase.

### 1. Downloading Data with `prefetch`
Always download the SRA object to local storage first. This tool handles downloads from NCBI, AWS, and GCP.

```bash
# Download a single accession
prefetch SRR1234567

# Download a list of accessions from a file
prefetch --option-file accessions.txt

# Download SRA Lite (smaller files, no base quality scores)
prefetch --eliminate-quals SRR1234567
```

### 2. Converting to FASTQ with `fasterq-dump`
`fasterq-dump` is the high-performance successor to `fastq-dump`. It uses temporary disk space and multiple threads to speed up conversion.

```bash
# Standard conversion for paired-end data
fasterq-dump --split-files SRR1234567

# Specify output directory and thread count
fasterq-dump --outdir ./fastq_out --threads 8 SRR1234567

# Include technical reads (often needed for single-cell data)
fasterq-dump --include-technical SRR1234567
```

## Configuration and Environment

Before first use, or when moving to a new environment (like an HPC cluster), configure the toolkit.

- **Interactive Configuration**: Run `vdb-config -i`.
- **Cloud Access**: If working on AWS or GCP, ensure "Report cloud instance identity" is enabled in the configuration to access data stored in the cloud providers' buckets.
- **Cache Location**: Use `vdb-config` to set the "Public Repository" path to a drive with sufficient space (SRA files can be hundreds of GBs).

## Expert Tips and Best Practices

- **Avoid `fastq-dump`**: Unless you have a very specific legacy requirement, always use `fasterq-dump`. It is orders of magnitude faster.
- **Disk Space**: `fasterq-dump` requires significant temporary disk space (roughly 3x the size of the final FASTQ). Use the `-t` or `--temp` flag to point to a high-capacity scratch directory if your `/tmp` is small.
- **Validation**: If a file seems corrupted, use `vdb-validate <accession>` to check the integrity of the downloaded SRA object.
- **Streaming**: If you absolutely cannot store the SRA file locally, `sam-dump` can be used to stream data directly into a pipeline, though this is sensitive to network instability.
- **dbGaP Data**: For protected data, you must use an `.ngc` credential file:
  ```bash
  prefetch --ngc /path/to/project.ngc SRR1234567
  ```



## Subcommands

| Command | Description |
|---------|-------------|
| fasterq-dump | Dump SRA data in FASTQ format |
| prefetch | Download SRA files and their dependencies |
| sra-stat | Display table statistics |
| vdb-validate | Examine directories, files and VDB objects, reporting any problems that can be detected. |

## Reference documentation

- [Home](./references/github_com_ncbi_sra-tools_wiki.md)
- [prefetch and fasterq dump](./references/github_com_ncbi_sra-tools_wiki_08.-prefetch-and-fasterq-dump.md)
- [Toolkit Configuration](./references/github_com_ncbi_sra-tools_wiki_05.-Toolkit-Configuration.md)
- [HowTo: fasterq dump](./references/github_com_ncbi_sra-tools_wiki_HowTo_-fasterq-dump.md)
- [Installing SRA Toolkit](./references/github_com_ncbi_sra-tools_wiki_02.-Installing-SRA-Toolkit.md)