---
name: minialign
description: minialign is a long-read alignment tool that maps sequencing data to reference genomes using minimizer-based indexing and SIMD-parallelized extension. Use when user asks to align long reads to a reference, build genome indices, or tune alignment scoring parameters for PacBio and Nanopore data.
homepage: https://github.com/ocxtal/minialign
---


# minialign

## Overview

minialign is a specialized alignment tool designed to handle the unique characteristics of long-read sequencing data. It balances speed and accuracy by combining minimizer-based indexing with SIMD-parallelized extension algorithms. Use this skill to generate SAM alignments, build reference indices for large genomes, and tune scoring parameters for specific sequencing technologies like PacBio or Nanopore.

## Common CLI Patterns

### Basic Alignment
Map long reads to a reference genome using a technology-specific preset:
```bash
minialign -xont.1dsq reference.fa reads.fastq > alignment.sam
```

### Index Management
For large genomes (e.g., Human), pre-building an index saves significant time in repetitive runs:
```bash
# Build the index
minialign -d reference.mai reference.fa

# Map using the pre-built index
minialign reference.mai reads.fastq > alignment.sam
```

### Performance Tuning
Utilize multi-threading to accelerate the alignment process:
```bash
minialign -t 16 -xpacbio reference.fa reads.fasta > alignment.sam
```

## Expert Parameters and Best Practices

### Technology Presets (-x)
Always start with a preset before manual tuning:
- `pacbio`: Optimized for Pacific Biosciences reads.
- `ont.1dsq`: Optimized for Oxford Nanopore 1D/2D reads.

### Scoring and Thresholds
If default alignments are too sparse or too noisy, adjust the scoring and reporting thresholds:
- `-s <int>`: Set the minimum score threshold (e.g., `-s 1000` for high-confidence matches).
- `-m <float>`: Set the report threshold as a fraction of the highest score (e.g., `-m 0.8`).
- `-a`, `-b`, `-p`, `-q`: Manually adjust match, mismatch, gap-open, and gap-extend penalties if presets are insufficient.

### Enabling Optional Tags
To include supplementary alignment or mismatch position information in the SAM output:
- `-TSA`: Enable SA (supplementary alignment) tags.
- `-TMD`: Enable MD (mismatch position) tags.

### Circular Reference Support
For bacterial genomes or plasmids, ensure circularity is handled:
- Use version 0.6.0+ which includes support for circular reference sequences.

## Reference documentation
- [minialign Overview](./references/anaconda_org_channels_bioconda_packages_minialign_overview.md)
- [minialign GitHub Repository](./references/github_com_ocxtal_minialign.md)