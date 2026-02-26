---
name: dragmap
description: DRAGMAP is an open-source genomic mapper and aligner that implements the DRAGEN algorithm for high-efficiency read mapping. Use when user asks to index reference genomes, build hash tables, or align sequencing reads to a reference.
homepage: https://github.com/Illumina/DRAGMAP
---


# dragmap

## Overview

DRAGMAP is the open-source version of the DRAGEN mapper/aligner, designed for high-efficiency genomic read mapping. This skill provides the necessary command-line patterns to index reference genomes and align sequencing data. It should be used when a user needs to process NGS data using the DRAGEN algorithm in an open-source environment, typically on Linux-based systems with significant memory resources.

## Installation

The most efficient way to install DRAGMAP is via Bioconda. Note that the executable binary is named `dragen-os`.

```bash
conda install -c bioconda dragmap
```

## Reference Indexing (Hash Table Generation)

Before alignment, you must build a hash table from your reference FASTA file.

### Basic Hash Table Build
```bash
dragen-os --build-hash-table true \
  --ht-reference reference.fasta \
  --output-directory ./reference_dir/
```

### Build with Alt-Masking
For human genome (hg38) alignments, it is recommended to use an alt-masked BED file to improve mapping quality in highly polymorphic regions.
```bash
dragen-os --build-hash-table true \
  --ht-reference hg38.fa \
  --output-directory ./reference_dir/ \
  --output-file-prefix dragmap.hg38_alt_masked \
  --ht-mask-bed hg38_alt_mask.bed
```

## Read Alignment

DRAGMAP supports both single-end and paired-end FASTQ inputs.

### Paired-End Alignment (Standard Output)
```bash
dragen-os -r ./reference_dir/ -1 reads_1.fastq.gz -2 reads_2.fastq.gz > result.sam
```

### Paired-End Alignment (Direct to File)
Using the `--output-directory` flag is often more stable for large datasets.
```bash
dragen-os -r ./reference_dir/ \
  -1 reads_1.fastq.gz \
  -2 reads_2.fastq.gz \
  --output-directory ./output/ \
  --output-file-prefix sample_name
```

### Single-End Alignment
```bash
dragen-os -r ./reference_dir/ -1 reads.fastq.gz > result.sam
```

## Expert Tips and Best Practices

*   **Hardware Requirements**: DRAGMAP is memory-intensive. Ensure the system has at least **64GB of RAM** available for the alignment process.
*   **Binary Name**: Always use the command `dragen-os`. The package name is `dragmap`, but the tool itself follows the DRAGEN naming convention.
*   **Reference Directory**: The `-r` (or `--ref-dir`) argument must point to the directory containing the generated hash table files, not the original FASTA file.
*   **Performance**: DRAGMAP is optimized for x86_64 architectures. While it can be compiled on other systems, performance is best on Intel/AMD processors.
*   **Help Command**: For a full list of advanced parameters (such as gap penalties or clipping settings), use:
    ```bash
    dragen-os --help
    ```

## Reference documentation
- [DRAGMAP GitHub Repository](./references/github_com_Illumina_DRAGMAP.md)
- [Bioconda Dragmap Overview](./references/anaconda_org_channels_bioconda_packages_dragmap_overview.md)