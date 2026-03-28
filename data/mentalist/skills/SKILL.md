---
name: mentalist
description: MentaLiST is a k-mer based tool designed for rapid bacterial genotyping and Multi-Locus Sequence Typing (MLST) from raw sequencing reads. Use when user asks to download MLST schemes, build k-mer databases, call alleles for pathogen surveillance, or detect novel alleles.
homepage: https://github.com/WGS-TB/MentaLiST
---


# mentalist

## Overview

MentaLiST is a specialized tool designed for rapid bacterial genotyping using a k-mer counting algorithm. Unlike traditional alignment-based methods, it identifies alleles by matching k-mers from raw sequencing reads against a pre-built database of known alleles. This approach makes it significantly faster and less resource-intensive, especially when dealing with the massive gene sets found in core genome or whole genome MLST schemes. It is implemented in Julia and is optimized for pathogen outbreak surveillance and large-scale genomic epidemiology.

## Installation and Setup

The most reliable way to run MentaLiST is via Docker to avoid Julia dependency conflicts.

- **Docker**: `docker pull matnguyen/mentalist:latest`
- **Execution**: `docker run -v ${PWD}:/data matnguyen/mentalist mentalist [command]`
- **Manual**: Requires Julia >= 1.1 and specific packages (BioSequences, DataStructures, etc.).

## Core Workflows

### 1. Database Preparation
Before calling alleles, you must download a schema and build a k-mer index.

**Download from PubMLST:**
```bash
mentalist download_pubmlst -s "Species Name" -o output_dir
```

**Download from EnteroBase:**
```bash
mentalist download_enterobase -s "Species Name" -t "cgMLST" -o output_dir
```

**Build the Index:**
```bash
mentalist build_db --db db_name -f fasta_files.txt -k 31
```
*Note: Use a k-mer size (default 31) appropriate for your data; larger k-mers increase specificity but may reduce sensitivity in highly divergent samples.*

### 2. Allele Calling
Perform genotyping on raw FASTQ files (supports gzipped files).

```bash
mentalist call --db db_name -f reads_1.fastq.gz reads_2.fastq.gz -o results.csv
```

### 3. Novel Allele Detection
MentaLiST can identify potential new alleles that are not present in the initial database.

```bash
mentalist call --db db_name -f reads.fastq.gz -o results.csv --novel_alleles novel.fasta
```

## Expert Tips and Best Practices

- **Memory Management**: For very large wgMLST schemes, use the `-c` (allele coverage) option during database building to compress the scheme. This requires the Gurobi ILP solver.
- **Input Formats**: MentaLiST accepts both single-end and paired-end reads. For paired-end, simply list both files after the `-f` flag.
- **Performance**: Because it is k-mer based, MentaLiST's speed is largely independent of the number of alleles in the database, making it the preferred choice for cgMLST/wgMLST over tools like SRST2.
- **Output Interpretation**: The primary output is a CSV file containing the best-matching allele for each locus in the scheme. Check the "votes" or "coverage" metrics if provided to assess the confidence of the call.



## Subcommands

| Command | Description |
|---------|-------------|
| build_db | Build a kmer database for MLST profiling. |
| download_enterobase | Download scheme data from Enterobase. |
| list_cgmlst | List available cgMLST schemes. |
| list_pubmlst | List available schemes from PubMLST |
| mentalist | A command-line tool for analyzing microbial genomic data. |
| mentalist | A tool for MLST analysis. |
| mentalist | A command-line tool for k-mer analysis and database operations. |
| mentalist call | Calls alleles on a given MLST database. You can create a custom DB with 'create_db' or other MentaLiST functions that download schemes from pubmlst, cgmlst.org or Enterobase. |
| mentalist db_info | MentaLiST kmer database information |
| mentalist download_cgmlst | Download a cgMLST scheme from the cgMLST finder database. |
| mentalist download_pubmlst | Download a scheme from PubMLST and create a kmer database. |

## Reference documentation
- [MentaLiST README](./references/github_com_WGS-TB_MentaLiST_blob_master_README.md)
- [Basic Usage Guide](./references/github_com_WGS-TB_MentaLiST_blob_master_docs_Basic_20Usage.ipynb.md)
- [Novel Allele Detection](./references/github_com_WGS-TB_MentaLiST_blob_master_docs_Novel_20allele_20detection_20with_20MentaLiST.ipynb.md)