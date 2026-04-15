---
name: htseq
description: HTSeq is a Python-based framework used to quantify gene expression by counting aligned high-throughput sequencing reads that overlap with genomic features. Use when user asks to count reads in a BAM or SAM file, quantify gene expression from RNA-Seq data, or perform quality assessment on sequencing files.
homepage: https://github.com/htseq/htseq
metadata:
  docker_image: "quay.io/biocontainers/htseq:2.1.2--py311hb6b0eea_0"
---

# htseq

## Overview

HTSeq is a powerful Python-based framework designed for the analysis of high-throughput sequencing data. Its primary utility lies in the `htseq-count` script, which serves as a standard tool for quantifying gene expression by counting how many aligned reads overlap with specific genomic features (like exons or genes). Beyond simple counting, HTSeq provides a comprehensive Python API for developers to build custom bioinformatic pipelines, offering specialized classes for handling genomic intervals, read alignments, and feature metadata.

## Command Line Usage Patterns

### htseq-count: Quantifying Gene Expression
The most common use case is counting reads in a BAM file that overlap with features in a GTF file.

**Basic usage:**
```bash
htseq-count -f bam -r name -s no -t exon -i gene_id aligned_reads.bam features.gtf > counts.txt
```

**Key Parameters:**
- `-f | --format`: Specify input format (`bam`, `sam`).
- `-r | --order`: Sorting order of the alignment file (`name` or `pos`). For paired-end data, `name` is strongly recommended to ensure mates are processed together efficiently.
- `-s | --stranded`: Whether the data is stranded (`yes`, `no`, or `reverse`). Use `reverse` for most modern Illumina TruSeq "stranded" protocols.
- `-t | --type`: The feature type (3rd column in GTF) to count (default: `exon`).
- `-i | --idattr`: The attribute in the GTF info column to use as the feature ID (default: `gene_id`).
- `-m | --mode`: Overlap resolution mode (`union`, `intersection-strict`, `intersection-nonempty`). `union` is the standard for most RNA-Seq workflows.

### htseq-count-barcodes: Single-Cell and UMI Counting
Used for single-cell RNA-Seq where cell barcodes and UMIs are present.

```bash
htseq-count-barcodes -f bam -r name -s yes --cell-barcode-tag CB --umi-tag UB aligned_reads.bam features.gtf > counts.tsv
```

### htseq-qa: Quality Assessment
Generates a quick quality report from a FASTQ or SAM/BAM file.

```bash
htseq-qa -f bam aligned_reads.bam
```

## Expert Tips and Best Practices

### 1. Sorting Requirements
While `htseq-count` can handle position-sorted files, it is significantly more memory-efficient to use **name-sorted** files for paired-end data. If your BAM is position-sorted, you can re-sort it using samtools:
```bash
samtools sort -n -o name_sorted.bam position_sorted.bam
```

### 2. Handling Multiple Feature Types
If you need to count reads across multiple feature types (e.g., both `exon` and `transcript`), you can provide multiple types:
```bash
htseq-count --type=exon --type=transcript aligned.bam features.gtf
```

### 3. Performance Optimization
For large datasets, use the `-n` or `--nprocesses` flag to enable multiprocessing:
```bash
htseq-count -n 8 aligned.bam features.gtf
```

### 4. Understanding Overlap Modes
- **union**: A read is counted if it overlaps any part of a feature. If it overlaps multiple features, it is marked as `__ambiguous`.
- **intersection-strict**: A read is counted only if it is entirely contained within the feature boundaries.
- **intersection-nonempty**: A read is counted if its overlap with one feature is unique, even if it partially overlaps others.

## Python API Snippet
For custom analysis, use the HTSeq library directly:

```python
import HTSeq

# Iterate through a BAM file
bam_reader = HTSeq.BAM_Reader("aligned.bam")
for alignment in bam_reader:
    if alignment.aligned:
        print(f"Read {alignment.read.name} aligned to {alignment.iv.chrom}:{alignment.iv.start}")

# Parse a GTF file
gtf_features = HTSeq.GFF_Reader("features.gtf")
for feature in gtf_features:
    print(f"Feature {feature.name} at {feature.iv}")
```



## Subcommands

| Command | Description |
|---------|-------------|
| htseq-count | This script takes one or more alignment files in SAM/BAM format and a feature file in GFF format and calculates for each feature the number of reads mapping to it. |
| htseq-count-barcodes | This script takes one alignment file in SAM/BAM format and a feature file in GFF format and calculates for each feature the number of reads mapping to it, accounting for barcodes. |
| htseq-qa | This script takes a file with high-throughput sequencing reads and performs a simple quality assessment by producing plots showing the distribution of called bases and base-call quality scores by position within the reads. The plots are output as a PDF file. |

## Reference documentation
- [htseq-count: counting reads within features](./references/htseq_readthedocs_io_en_latest_htseqcount.html.md)
- [htseq-count-barcodes: counting reads with cell barcodes and UMIs](./references/htseq_readthedocs_io_en_latest_htseqcount_with_barcodes.html.md)
- [Read alignments API](./references/htseq_readthedocs_io_en_latest_alignments.html.md)
- [Quality Assessment with htseq-qa](./references/htseq_readthedocs_io_en_latest_qa.html.md)