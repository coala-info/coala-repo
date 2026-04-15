---
name: eskrim
description: Eskrim performs reference-free microbial richness estimation from shotgun metagenomic sequencing data using k-mer distributions. Use when user asks to estimate microbial richness, generate k-mer profiles from metagenomic reads, or compare diversity across samples without a reference genome.
homepage: https://forgemia.inra.fr/metagenopolis/eskrim
metadata:
  docker_image: "quay.io/biocontainers/eskrim:1.0.9--pyhdfd78af_1"
---

# eskrim

## Overview
ESKRIM (EStimate with K-mers the RIchness in a Microbiome) is a specialized bioinformatics tool designed for reference-free microbial richness estimation. It operates on shotgun metagenomic sequencing data by analyzing k-mer distributions. This approach is particularly valuable when working with complex environmental or clinical samples where many species lack high-quality reference genomes, allowing for a direct comparison of richness between different metagenomic datasets.

## Installation and Setup
The tool is primarily distributed via Bioconda. Ensure your environment is configured with the necessary channels before installation.

```bash
# Install eskrim via conda
conda install -c bioconda eskrim
```

## Core Usage Patterns
While specific subcommands depend on the version installed, the general workflow involves processing raw or filtered metagenomic reads (FASTQ) to generate k-mer profiles and richness estimates.

### Basic Command Structure
The standard execution follows a typical CLI pattern:
```bash
eskrim [options] -i <input_fastq> -o <output_directory>
```

### Key Parameters
*   **K-mer Size (-k):** Choosing the right k-mer length is critical. Smaller k-mers (e.g., 21-31) are generally used for richness estimation to balance sensitivity and computational efficiency.
*   **Input Format:** Supports shotgun metagenomic reads. Ensure reads are quality-trimmed before processing for more accurate richness estimates.
*   **Reference-Free Comparison:** Use the output statistics to compare the "observed" k-mer richness across multiple samples to infer differences in microbial diversity.

## Expert Tips
*   **Data Normalization:** When comparing richness between samples, ensure that sequencing depth is either normalized or accounted for, as k-mer counts are sensitive to the total number of reads.
*   **Memory Management:** K-mer counting is memory-intensive. Monitor RAM usage when processing large metagenomic datasets.
*   **Quality Control:** Always run a quality control step (like FastQC) before using eskrim. High error rates in sequencing reads can artificially inflate k-mer richness by creating "unique" k-mers that are actually sequencing artifacts.

## Reference documentation
- [eskrim - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_eskrim_overview.md)