---
name: lrez
description: LRez is a suite of tools designed for the efficient indexing, extraction, and spatial analysis of linked-read data based on molecular barcodes. Use when user asks to index FASTQ files by barcode, extract specific reads for local assembly, or identify barcode overlaps between genomic regions to detect structural variants.
homepage: https://github.com/flegeai/LRez
---


# lrez

## Overview

LRez is a suite of tools designed for efficient manipulation of linked-read data. It solves the challenge of randomly accessing reads associated with specific molecular barcodes without scanning entire datasets. Use this skill to index large FASTQ files for rapid retrieval, extract subsets of reads for local assembly or analysis, and perform spatial barcode analysis on BAM files to identify shared molecular origins across different genomic coordinates.

## Core Workflows

### 1. Indexing FASTQ Files by Barcode
Before extracting reads, you must create an index of the barcode locations within the FASTQ file.

```bash
python3 idx_bx_sqlite3.py -bx input_barcoded.fastq.gz -idx output.idx -m sqlite
```
- **Best Practice**: Use `-m sqlite` (default) for large datasets as it is more robust than the `shelve` mode.
- **Note**: Ensure the input FASTQ is gzipped if using the default `-z` (true) setting.

### 2. Extracting Reads by Barcode
Once indexed, you can pull all reads belonging to a specific set of barcodes.

```bash
python3 reads_bx_sqlite3.py -f input_barcoded.fastq.gz -i output.idx -b barcode_list.txt
```
- **Input**: `barcode_list.txt` should contain one barcode per line.
- **Efficiency**: This method is significantly faster than `grep` or standard stream processing for targeted extraction.

### 3. Extracting Barcodes from BAM Regions
To see which barcodes are present in a specific genomic window:

```bash
BamExtractor input.bam "Scaffold123:100000-200000"
```
- **Requirement**: The BAM file must be indexed (e.g., via `samtools index`).

### 4. Comparing Barcode Overlaps
To identify common barcodes between different regions (useful for detecting structural variants or scaffolding):

```bash
# Pairwise comparison of regions in a list
Compare --bam input.bam --list regions.txt

# Compare a specific contig against all others
Compare --bam input.bam --in ContigA --size 1000
```
- **Tip**: The `--size` parameter defines the boundary regions (default 1000bp) to consider when looking for overlaps at contig ends.

## Expert Tips

- **Memory Management**: When working with massive FASTQ files, ensure you have sufficient disk space for the SQLite index, which can grow quite large depending on the number of unique barcodes.
- **Environment**: LRez requires `htslib` and `indexed_gzip`. If running into execution errors, verify these C-libraries and Python modules are correctly linked in your environment.
- **Data Compatibility**: While designed for 10X Genomics "Long Ranger" basic outputs, the tools work on any FASTQ where the barcode is formatted in the read header in a compatible way.

## Reference documentation
- [LRez GitHub Repository](./references/github_com_flegeai_LRez.md)
- [Bioconda LRez Package Overview](./references/anaconda_org_channels_bioconda_packages_lrez_overview.md)