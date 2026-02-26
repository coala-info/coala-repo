---
name: srahunter
description: srahunter downloads sequencing data from the NCBI SRA database and converts it into FASTQ format while retrieving associated metadata. Use when user asks to download SRA accessions, convert SRA files to FASTQ, or retrieve standard and full metadata for sequencing runs.
homepage: https://github.com/GitEnricoNeko/srahunter
---


# srahunter

## Overview
The `srahunter` skill enables efficient interaction with the NCBI SRA database. It is particularly useful for bioinformaticians who need to process lists of SRA accessions to obtain raw sequencing data (Illumina, PACBio, or ONT) or structured metadata. The tool automates the conversion of `.sra` files to FASTQ, manages disk space checks, and provides resume capabilities for interrupted downloads.

## Core Commands

### 1. Downloading Data
Use `srahunter download` to fetch SRA files and convert them to FASTQ.
- **Input**: Requires a text file containing a list of Run accession numbers (e.g., SRR8487013).
- **Command Pattern**: `srahunter download -i <accession_list.txt> [options]`
- **Key Options**:
  - `-t`: Set threads (default: 6).
  - `-p`: Specify temporary path for `.sra` files.
  - `-o`: Specify output directory for `.fastq` files.
  - `-ms`: Set maximum SRA file size (default: 50G).

### 2. Metadata Retrieval
Use `srahunter metadata` for standard metadata or `srahunter fullmetadata` for comprehensive details.
- **Standard**: `srahunter metadata -i <accession_list.txt>`
  - Outputs `SRA_info.csv` and an interactive HTML table in `SRA_html/`.
- **Full (BETA)**: `srahunter fullmetadata -i <accession_list.txt>`
  - Outputs `Full_SRA_info.csv` containing all available metadata fields.

## Expert Tips & Best Practices
- **Disk Management**: The tool requires at least 20GB of free space to start a download. It automatically deletes `.sra` files after successful conversion to FASTQ to save space.
- **Resuming Jobs**: If a download is interrupted, re-run the same command. The tool tracks progress and resumes from the last successful sample.
- **Error Tracking**: Check `failed_list.csv` after a run to identify specific accessions that failed to download or convert.
- **Installation**: For the best experience, install via Bioconda using Mamba: `mamba install bioconda::srahunter`.
- **Accession Format**: Ensure the input list contains only Run accessions (SRR/ERR/DRR). Other accession types (SRP, PRJ, etc.) are currently not supported for direct download.

## Reference documentation
- [srahunter GitHub Repository](./references/github_com_GitEnricoNeko_srahunter.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_srahunter_overview.md)