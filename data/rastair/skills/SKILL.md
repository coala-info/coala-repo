---
name: rastair
description: rastair is a high-performance tool written in Rust designed specifically for methylation calling from TAPS sequencing data.
homepage: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/
---

# rastair

## Overview
rastair is a high-performance tool written in Rust designed specifically for methylation calling from TAPS sequencing data. Unlike traditional bisulfite sequencing (BS-Seq) which converts unmethylated cytosines to uracil, TAPS converts methylated cytosines to thymine. rastair efficiently identifies these C-to-T transitions in TAPS-aligned reads to provide accurate methylation frequencies across the genome.

## Installation
Install rastair via Bioconda:
```bash
conda install bioconda::rastair
```

## Core Usage Pattern
The primary command for methylation calling is `rastair call`. This requires a coordinate-sorted, indexed BAM file and the corresponding reference genome.

### Basic Methylation Calling
```bash
rastair call \
    --bam input_sorted.bam \
    --ref reference.fasta \
    --output methylation_calls.vcf \
    --threads 8
```

### Key Parameters
- `--bam` / `-b`: Input BAM file (must be indexed).
- `--ref` / `-r`: Reference genome in FASTA format.
- `--output` / `-o`: Output file path (typically VCF or tabular format).
- `--sample` / `-s`: Sample name to be used in the output header.
- `--min-mapq` / `-q`: Minimum mapping quality (default is often 10-30; use 30 for high confidence).
- `--min-baseq` / `-Q`: Minimum base quality for the calling position.

## Expert Tips and Best Practices
- **Alignment Strategy**: Ensure reads were aligned using a TAPS-aware aligner or a standard aligner with parameters optimized for C-to-T transitions. Since TAPS converts 5mC to T, the logic is the inverse of bisulfite sequencing.
- **MAPQ Filtering**: Always use a minimum mapping quality filter (`-q 30`) to avoid false positives in repetitive regions, which are common in methylation analysis.
- **Resource Allocation**: rastair is highly parallelizable. Scale the `--threads` parameter based on available CPU cores to significantly reduce processing time for deep-coverage whole-genome data.
- **Memory Management**: While Rust provides memory efficiency, ensure the reference FASTA is indexed (`samtools faidx`) to allow rastair to perform random access efficiently.

## Reference documentation
- [rastair Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rastair_overview.md)
- [rastair Source and Documentation](./references/bitbucket_org_bsblabludwig_rastair_src_v0.8.2.md)