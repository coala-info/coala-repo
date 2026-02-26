---
name: kcounter
description: kcounter performs high-performance DNA k-mer counting from genomic datasets using a Rust-based backend. Use when user asks to count k-mers in FASTA or FASTQ files, analyze k-mer distributions, or evaluate genome assemblies.
homepage: http://apcamargo.github.io/kcounter/
---


# kcounter

## Overview
kcounter provides a streamlined interface for DNA k-mer counting, leveraging Rust's performance for the heavy computational lifting while maintaining a simple Python-friendly environment. It is designed for researchers and bioinformaticians who need to process large genomic datasets to identify k-mer distributions, which are essential for tasks like genome assembly evaluation, metagenomic profiling, and sequence alignment.

## Usage Guidelines

### Installation
The package is primarily distributed via Bioconda. Ensure the `bioconda` and `conda-forge` channels are configured before installation.
```bash
conda install -c bioconda kcounter
```

### Core Functionality
While kcounter is written in Rust, it is typically invoked as a Python library or via its command-line interface to generate k-mer counts from FASTA/FASTQ files.

- **K-mer Length Selection**: Choose a k-mer size (k) based on your specific biological question. Common values range from 21 to 31 for genome assembly tasks.
- **Input Formats**: The tool natively supports standard sequence formats. Ensure input files are decompressed or handled according to the specific version requirements.
- **Performance**: Because it is implemented in Rust, it handles multi-threading efficiently. When running on large datasets (e.g., human genome or large metagenomes), ensure sufficient RAM is allocated for the k-mer hash table.

### Best Practices
- **Canonical K-mers**: When counting, decide if you need to count reverse complements as the same k-mer (canonical k-mers). This is standard for most genomic analyses to account for the double-stranded nature of DNA.
- **Filtering**: For high-depth sequencing data, consider filtering out low-frequency k-mers (e.g., count < 2) which often represent sequencing errors, to reduce memory overhead.

## Reference documentation
- [kcounter Overview](./references/anaconda_org_channels_bioconda_packages_kcounter_overview.md)