---
name: salmid
description: SalmID is a k-mer based tool for the rapid taxonomic identification and contamination screening of Salmonella isolates from sequencing data. Use when user asks to identify Salmonella species or subspecies, verify isolate purity, or detect common contaminants like Escherichia and Listeria in genomic samples.
homepage: https://github.com/hcdenbakker/SalmID
metadata:
  docker_image: "biocontainers/salmid:v0.1.23-1-deb_cv1"
---

# salmid

## Overview
SalmID is a specialized k-mer based tool designed for the rapid taxonomic identification of Salmonella isolates. It allows researchers to quickly verify the species and subspecies of a sample directly from sequencing data, providing a high-speed alternative to more computationally intensive assembly-based methods. Beyond Salmonella identification, it serves as a quality control check by flagging the presence of common contaminants like Escherichia and Listeria.

## Command Line Usage

The primary executable for this tool is `SalmID.py`. It supports both individual file analysis and batch processing of directories.

### Basic Commands

**Analyze a single sample:**
Use the `-i` flag to specify a single FASTQ file (supports `.fastq` or `.fastq.gz`).
```bash
SalmID.py -i sample_R1.fastq.gz
```

**Batch process the current directory:**
Use the `-e` flag to target all files matching a specific extension.
```bash
SalmID.py -e .fastq.gz
```

**Analyze files in a specific directory:**
Combine the `-d` flag for the path and `-e` for the file extension.
```bash
SalmID.py -d ./raw_data/ -e _1.fastq.gz
```

## Best Practices and Tips

- **Isolate Purity**: SalmID is optimized for single isolate samples. While it can detect common contaminants, it is not intended for complex metagenomic community analysis.
- **File Extensions**: When using batch mode (`-e`), ensure your extension string is specific enough to avoid processing unintended files (e.g., use `_R1.fastq.gz` if you only want to process the forward reads of paired-end data to save time).
- **Input Formats**: The tool natively handles compressed (`.gz`) FASTQ files, which is the standard output for most Illumina platforms. There is no need to decompress files before running SalmID.
- **Taxonomic Scope**: Currently, the tool focuses on:
    - Salmonella species and subspecies.
    - Escherichia (common contaminant).
    - Listeria (common contaminant).

## Reference documentation
- [SalmID Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_salmid_overview.md)
- [SalmID GitHub Repository](./references/github_com_hcdenbakker_SalmID.md)