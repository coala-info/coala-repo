---
name: srahunter
description: srahunter automates the downloading of NCBI Sequence Read Archive data, converts it to FASTQ format, and retrieves associated metadata. Use when user asks to download SRA runs, convert SRA files to FASTQ, or generate metadata reports and summary tables for SRA accessions.
homepage: https://github.com/GitEnricoNeko/srahunter
metadata:
  docker_image: "quay.io/biocontainers/srahunter:0.0.9--pyhdfd78af_0"
---

# srahunter

## Overview

srahunter is a specialized bioinformatics utility designed to streamline the interaction with the NCBI Sequence Read Archive. It simplifies the often cumbersome process of fetching raw sequencing data by automating the download of `.sra` files, converting them into single or paired-end FASTQ files, and performing automatic cleanup of temporary files to manage disk space. Beyond data retrieval, it provides robust metadata harvesting capabilities, allowing researchers to quickly generate summary tables or interactive HTML reports for large lists of SRA accessions.

## Installation

The tool is available via Bioconda. It is recommended to use `mamba` for faster dependency resolution:

```bash
mamba install bioconda::srahunter
# OR
conda install bioconda::srahunter
```

## Core Workflows

### 1. Downloading and Converting Data
Use the `download` module to fetch SRA runs and convert them to FASTQ.

```bash
srahunter download -i accession_list.txt [options]
```

**Key Options:**
- `-i, --list`: Path to a text file containing SRA Run accessions (e.g., SRR8487013), one per line.
- `-t`: Number of threads for parallel processing (default: 6).
- `-o, --outdir`: Directory for the final `.fastq` files (default: current directory).
- `-p, --path`: Temporary directory for raw `.sra` files (default: `./tmp_srahunter`).
- `--gzip`: Optional flag to compress output into `.fastq.gz`.
- `-ms, --maxsize`: Maximum size limit for each SRA file (default: 50G).

### 2. Metadata Retrieval
Generate structured reports of the most important metadata associated with your accessions.

```bash
srahunter metadata -i accession_list.txt
```

- **Output**: Produces `SRA_info.csv` and an interactive HTML table in the `SRA_html/` folder.
- **Tip**: Use `--no-html` if you only require the CSV output.

### 3. Full Metadata (BETA)
Retrieve every available metadata field for the provided accessions.

```bash
srahunter fullmetadata -i accession_list.txt
```

- **Note**: This module is currently in BETA and is known to have issues with miRNA-seq data.

## Expert Tips and Best Practices

- **Accession Format**: Ensure your input list contains only **Run** accession numbers (starting with SRR, ERR, or DRR). Project or Study accessions are not currently supported.
- **Disk Space Management**: srahunter requires at least **20GB of free disk space** to initiate a download. It automatically deletes the bulky `.sra` files after a successful "dump" to FASTQ, significantly reducing the long-term storage footprint.
- **Resume Capability**: If a download is interrupted, simply run the same command again. The tool tracks successfully processed samples and will resume from where it left off.
- **Error Tracking**: Always check `failed_list.csv` after a large batch job to identify accessions that encountered network or processing errors.
- **Performance**: When working on high-core systems, scale the `-t` parameter to match your available CPU resources for faster FASTQ dumping.



## Subcommands

| Command | Description |
|---------|-------------|
| srahunter download | Download SRA data and convert it to FASTQ format. |
| srahunter fullmetadata | Accession list from SRA (file path) |
| srahunter metadata | Accession list from SRA (file path) |

## Reference documentation
- [srahunter README](./references/github_com_GitEnricoNeko_srahunter_blob_main_README.md)
- [srahunter CLI Specification](./references/github_com_GitEnricoNeko_srahunter_blob_main_cli.py.md)