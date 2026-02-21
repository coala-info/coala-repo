---
name: humid
description: HUMID (High-performance UMI Deduplicator) is a tool for the rapid removal of duplicate reads from FastQ files.
homepage: https://github.com/jfjlaros/HUMID
---

# humid

## Overview
HUMID (High-performance UMI Deduplicator) is a tool for the rapid removal of duplicate reads from FastQ files. Unlike many other deduplication tools, HUMID is reference-free, meaning it operates directly on raw sequencing data without requiring prior alignment to a genome. It utilizes clustering based on edit distance or Hamming distance to identify and collapse duplicates, making it an efficient pre-processing step for NGS pipelines.

## Installation
The recommended way to install HUMID is via Bioconda:
```bash
conda install -c bioconda humid
```

## Common CLI Patterns

### 1. Standard Paired-End Deduplication
Use this pattern if your reads do not have UMIs, or if the UMIs have already been moved into the FastQ headers (e.g., by BCL Convert).
```bash
humid forward.fastq.gz reverse.fastq.gz
```

### 2. Deduplication with a Separate UMI File
If your UMIs are stored in a third, separate FastQ file, provide all three files as arguments.
```bash
humid forward.fastq.gz reverse.fastq.gz umi.fastq.gz
```

### 3. Pre-processing for Non-Standard UMI Locations
If UMIs are present in the sequence but not in the header or a separate file, use `fastp` to move the UMIs to the read headers before running HUMID. This ensures HUMID can correctly identify duplicates based on the UMI sequence.

## Expert Tips and Best Practices
- **Reference-Free Advantage**: Because HUMID does not require alignment, use it as an early pre-processing step to reduce the computational load of downstream mapping and variant calling.
- **Input Formats**: HUMID accepts both plain and gzipped FastQ files.
- **Clustering Logic**: The tool identifies duplicates by looking for identical or near-identical sequences. When UMIs are provided, it uses them to distinguish between PCR duplicates and biological duplicates.
- **Performance**: HUMID is optimized for speed; however, ensure your system has sufficient memory for the clustering process, especially with very large datasets.

## Reference documentation
- [HUMID: reference free FastQ deduplication](./references/github_com_jfjlaros_HUMID.md)
- [humid - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_humid_overview.md)