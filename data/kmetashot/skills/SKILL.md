---
name: kmetashot
description: kMetaShot performs rapid taxonomic assignment of microbial genomes and metagenome-assembled bins using an alignment-free minimizer approach. Use when user asks to classify microbial bins, assign taxonomy to metagenome-assembled genomes, or perform rapid taxonomic profiling of genomic datasets.
homepage: https://github.com/gdefazio/kMetaShot
---


# kmetashot

## Overview

kMetaShot is a specialized tool designed for the rapid taxonomic assignment of microbial genomes recovered from metagenomic datasets. By utilizing an alignment-free approach based on minimizers, it provides a computationally efficient alternative to traditional alignment-based classifiers. It is optimized for classifying bins or MAGs rather than raw reads, making it a key component of post-binning metagenomic workflows.

## Installation and Setup

The tool is primarily distributed via Bioconda. It requires a significant amount of memory and a specific reference database.

### Environment Setup
```bash
conda create --name kmetashot -c bioconda kmetashot=2.0
conda activate kmetashot
```

### Reference Database
kMetaShot requires an HDF5 reference file (representing prokaryotic RefSeq genomes), which typically requires ~22GB of storage. Ensure you have downloaded the latest release (e.g., RefSeq 2025/05/22) before running the classifier.

### Verification
Before processing real data, verify the installation and reference integrity:
```bash
kMetaShot_test.py -r /path/to/kMetaShot_reference.h5
```

## Classification Workflow

The primary command for classification is `kMetaShot_classifier_NV.py`.

### Basic Usage
```bash
kMetaShot_classifier_NV.py -b <bins_directory> -r <reference.h5> -o <output_dir>
```

### Common CLI Patterns

**High-Performance Execution:**
To speed up classification on multi-core systems, use the `-p` flag. Note that increasing parallelism significantly increases RAM consumption.
```bash
kMetaShot_classifier_NV.py -b ./my_bins/ -r ./ref.h5 -p 16 -o ./results/
```

**Stringent Filtering:**
Use the `-a` (ass2ref) parameter to filter results. This represents the ratio between the number of MAG minimizers and the reference minimizers related to the assigned strain.
```bash
# Set a threshold of 0.1 for higher confidence assignments
kMetaShot_classifier_NV.py -b ./bins/ -r ./ref.h5 -a 0.1 -o ./filtered_results/
```

## Expert Tips and Best Practices

*   **Input Formats:** The tool accepts `.fa`, `.fasta`, `.fna` files, as well as their gzipped versions (`.gz`). You can provide a directory of files or a single multi-fasta file where each header represents a bin.
*   **Memory Management:** If running in a Docker container, you must specify `--shm-size=22g` (or higher) to accommodate the reference database in shared memory.
*   **Resource Planning:** Because the tool loads the reference into memory, ensure the host system has at least 32GB of RAM available, especially when using multiple processes (`-p`).
*   **Output Interpretation:** The output directory will contain taxonomic assignments for each bin provided in the input.

## Reference documentation
- [kMetaShot GitHub Repository](./references/github_com_gdefazio_kMetaShot.md)
- [kMetaShot Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kmetashot_overview.md)