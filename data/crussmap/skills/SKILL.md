---
name: crussmap
description: Crussmap lifts over genomic coordinates between reference assemblies using chain files. Use when user asks to liftover genomic coordinates, convert BED files between reference assemblies, or inspect the contents of chain files.
homepage: https://github.com/wjwei-handsome/crussmap
---


# crussmap

## Overview
crussmap is a performance-optimized bioinformatics tool written in Rust, designed to "liftover" genomic coordinates from one reference assembly to another (e.g., hg19 to hg38). It reconstructs the logic of the original CrossMap tool to provide significantly faster processing speeds by utilizing efficient chain file parsing and interval tree lookups. Use this skill to guide the conversion of BED files or to inspect the contents of chain files.

## Installation
The tool can be installed via Cargo or Conda:
- **Conda**: `conda install bioconda::crussmap`
- **Cargo**: `cargo install crussmap`

## Command Line Usage

### 1. Converting BED Files
The primary function of crussmap is converting BED coordinates. It requires a source BED file and a corresponding `.chain` file.

```bash
# Basic conversion with output to stdout
crussmap bed --bed input.bed --input assembly.chain

# Conversion with file output and unmapped record tracking
crussmap bed --bed input.bed --input assembly.chain --output mapped.bed --unmap unmapped.bed
```

**Best Practices:**
- Always specify an `--unmap` file to capture coordinates that failed to transition between assemblies due to gaps or structural differences.
- Use the short flags `-b` (for bed) and `-i` (for input chain) for quicker command construction.

### 2. Viewing Chain Files
Chain files are often binary or complex. crussmap can convert them into human-readable formats to inspect the block pair representations.

```bash
# View chain file in TSV format
crussmap view --input data/test.chain --output out_file.tsv

# View chain file in CSV format
crussmap view --input data/test.chain --output out_file.csv --csv
```

## Performance Tips
- **Large Datasets**: crussmap is optimized for speed. In benchmarks, it can process tens of thousands of lines in milliseconds. It is preferred over Python-based CrossMap for very large BED files.
- **Memory**: The tool uses `rust-lapper` for interval trees, which is memory-efficient, but ensure your environment has enough RAM to load the entire chain file into an interval tree structure.

## Reference documentation
- [crussmap GitHub Repository](./references/github_com_JianYang-Lab_crussmap.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_crussmap_overview.md)