---
name: tracs
description: TRACS infers transmission links and genetic distances between bacterial samples by analyzing metagenomic data with an empirical Bayes approach. Use when user asks to build a reference database, align reads, calculate SNP distances, or identify transmission clusters and outbreaks.
homepage: https://github.com/gtonkinhill/tracs
metadata:
  docker_image: "quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1"
---

# tracs

## Overview

TRACS (Transmission Reconstruction from Metagenomic Samples) is a specialized bioinformatic tool designed to infer transmission links between bacterial samples. It is particularly robust when working with complex metagenomic data or samples containing multiple strains, where traditional single-reference SNP calling might fail or provide biased results. By employing an empirical Bayes approach and aligning reads to multiple reference genomes, TRACS provides a conservative "lower bound" estimate of the genetic distance (SNPs) and the number of intermediate hosts separating two samples.

## Installation and Dependencies

TRACS can be installed via Conda or Pip:

```bash
# Recommended: Conda installation
conda install bioconda::tracs

# Manual installation via Pip
pip3 install git+https://github.com/gtonkinhill/tracs
```

**Note**: For alignment functionality, ensure the following tools are installed and available in your PATH:
- `samtools`
- `minimap2`
- `htsbox`

## Core Command Line Usage

TRACS operates through a series of specialized modules. You can call them via the main `tracs` entry point or individual runner scripts.

### 1. Database Preparation
Before aligning reads, you must prepare the reference database.
- **Command**: `tracs build_db`
- **Purpose**: Indexes and prepares multiple reference genomes to allow for robust distance estimation across diverse genetic backgrounds.

### 2. Alignment
Map your metagenomic or isolate reads against the prepared database.
- **Command**: `tracs align`
- **Requirement**: Requires `minimap2` and `samtools`.
- **Best Practice**: Use this when you have raw FASTQ data and need to generate the intermediate alignment files required for distance calculation.

### 3. Distance Estimation
The core analytical step of TRACS.
- **Command**: `tracs distance`
- **Function**: Uses an empirical Bayes framework to calculate the pairwise SNP distances. It specifically accounts for variable coverage depths common in metagenomic sequencing.

### 4. Clustering and Thresholding
Once distances are calculated, use these modules to identify transmission clusters.
- **Commands**: `tracs threshold` and `tracs cluster`
- **Usage**: Define SNP cutoffs to group samples into potential transmission chains or outbreaks.

### 5. Pipeline Execution
For a streamlined workflow from raw data to results.
- **Command**: `tracs pipe`
- **Function**: Wraps the build, align, and distance steps into a single execution path.

### 6. Visualization
- **Command**: `tracs plot`
- **Function**: Generates visual representations of the transmission distances and clusters to aid in epidemiological interpretation.

## Expert Tips and Best Practices

- **SNP Distance Limits**: TRACS is optimized for high-resolution transmission inference (small SNP distances). It is not intended for estimating large phylogenetic distances between highly divergent strains.
- **Metagenomic Advantage**: When working with metagenomic samples, TRACS is superior to standard isolate-based pipelines because it doesn't assume a single dominant strain is present; it looks for the "closest" possible link between samples.
- **Lower Bound Interpretation**: Always remember that TRACS provides a **lower bound** estimate. This makes it a conservative tool for ruling out transmission (i.e., if the lower bound is high, transmission is very unlikely).
- **Reference Selection**: Aligning to multiple reference genomes helps mitigate "reference bias," where the choice of a single reference might hide SNPs in accessory genome regions.



## Subcommands

| Command | Description |
|---------|-------------|
| tracs build-db | Builds a database for tracs |
| tracs pipe | A script to run the full TRACS pipeline. |
| tracs_align | Uses sourmash to identify reference genomes within a read set and then aligns reads to each reference using minimap2 |
| tracs_cluster | Groups samples into putative transmission clusters using single linkage clustering |
| tracs_combine | Combine runs of TRACS'm align ready for distance estimation |
| tracs_distance | Estimates pairwise SNP and transmission distances between each pair of samples aligned to the same reference genome. |
| tracs_plot | Generates plots from a pileup file. |
| tracs_threshold | Estimates transmission thresholds. |

## Reference documentation
- [TRACS GitHub Repository](./references/github_com_gtonkinhill_tracs.md)
- [TRACS README](./references/github_com_gtonkinhill_tracs_blob_main_README.md)