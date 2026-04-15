---
name: hamip
description: HaMiP is a scalable pipeline for processing CMS-IP sequencing data to identify peaks and differential hydroxymethylation. Use when user asks to process raw FASTQ or BAM files, construct CMS measurements, or detect differential hydroxymethylation regions using various statistical tests.
homepage: https://github.com/lijinbio/HaMiP
metadata:
  docker_image: "quay.io/biocontainers/hamip:0.0.3.2--py_0"
---

# hamip

## Overview
HaMiP (Hydroxymethylation analysis of CMS-IP) is a scalable pipeline designed to process CMS-IP sequencing data. It automates the transition from raw sequencing reads to the identification of peaks and differential hydroxymethylation. The tool is highly modular, allowing users to skip time-consuming alignment steps if pre-aligned BAM files are available, and supports various statistical methods for detecting genomic variations in hydroxymethylation.

## Installation and Environment
The most efficient way to deploy HaMiP is via Bioconda, which automatically handles the extensive list of dependencies (including bedtools, R packages like DESeq2, and MOABS).

```bash
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda install hamip
```

## Core Workflow Patterns

### 1. End-to-End Processing (FASTQ Input)
When starting from raw reads, the tool performs alignment using the reference genome specified. This workflow requires:
- Absolute paths to raw FASTQ files.
- A reference genome FASTA file (e.g., hg38.fa).
- Optional spike-in FASTA files for normalization.

### 2. Accelerated Processing (BAM Input)
To save significant computation time, you can provide existing alignment files. In this mode, the mapping steps are bypassed.
- Set the input type to BAM.
- Provide absolute paths to the reference BAM files.
- If using spike-ins, provide the spike-in BAM files separately.

### 3. CMS Measurement Construction
The pipeline segments the genome into windows to calculate CMS measurements.
- **Read Extension**: It is recommended to set read extension to True and specify a fixed fragment size to improve measurement accuracy.
- **Window Size**: Adjust the window size based on the desired resolution of the hydroxymethylation landscape.
- **Measurement Type**: Choose between raw read counts or mean WIG values for the CMS measurement.

## Statistical Methods for DHMR Detection
HaMiP supports multiple statistical tests for identifying Differential Hydroxymethylation Regions (DHMRs). Choose the method based on your experimental design:

- **ttest**: Uses Student's t-test to compare mean CMS measurements between two groups.
- **chisq / gtest**: Pearson’s Chi-squared or G-test to evaluate if CMS sums fit replicate distributions.
- **nbtest**: Applies a Negative Binomial generalized linear model (GLM) with a Wald test. This is generally preferred for sequencing data with replicates as it accounts for overdispersion.
- **nbtest_sf**: Similar to nbtest but uses the median-ratio normalization algorithm (standard in DESeq2) for size factor adjustment.

## Expert Tips and Best Practices
- **Spike-in Normalization**: Always enable spike-in normalization if your library includes spike-in controls. This provides a more robust normalization factor than standard WIG sum reductions.
- **Independent Filtering**: Use the `meandepth` parameter to filter out low-depth windows before statistical testing. This reduces the multiple testing burden and increases overall statistical power.
- **Parallelization**: Optimize performance by adjusting `numthreads` and `nsplit`. The `nsplit` parameter controls how the genomic windows are partitioned for parallel processing.
- **Merging Regions**: Use `maxdistance` to control how adjacent significant windows (DHMWs) are merged into larger regions (DHMRs). A typical starting point is the size of your window or fragment.

## Reference documentation
- [HaMiP Overview](./references/anaconda_org_channels_bioconda_packages_hamip_overview.md)
- [HaMiP GitHub Repository](./references/github_com_lijinbio_HaMiP.md)