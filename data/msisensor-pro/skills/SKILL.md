---
name: msisensor-pro
description: MSIsensor-pro is a computational tool for determining microsatellite instability status from next-generation sequencing data with or without a matched normal sample. Use when user asks to scan a reference genome for microsatellites, build a baseline from normal samples, or perform MSI detection on tumor-normal pairs or tumor-only samples.
homepage: https://github.com/xjtu-omics/msisensor-pro
---


# msisensor-pro

## Overview

MSIsensor-pro is an advanced computational tool for determining MSI status from next-generation sequencing (NGS) data. It is an evolution of the original MSIsensor, optimized for better accuracy and lower computational cost. Its primary advantage is the ability to perform MSI detection without a matched normal sample by utilizing a discriminative sites selection method and a pre-built baseline (Panel of Normals). This makes it highly effective for clinical workflows where normal tissue may not be available.

## Installation

The recommended way to install msisensor-pro is via Bioconda:

```bash
conda install -c bioconda msisensor-pro
```

## Core Workflows and CLI Patterns

### 1. Reference Scanning (Preprocessing)
Before analysis, you must identify microsatellite sites in your reference genome. This step only needs to be performed once for a specific reference.

```bash
msisensor-pro scan -d reference.fa -o microsatellites.list
```
*   **-d**: Path to the reference genome FASTA file.
*   **-o**: Output file for the microsatellite site list.

### 2. Tumor-Normal Paired Analysis
Use this when you have sequencing data for both the tumor and a matched normal sample.

```bash
msisensor-pro msi -d microsatellites.list -n normal.bam -t tumor.bam -o output_prefix
```
*   **-d**: The list generated in the scan step.
*   **-n**: Matched normal BAM file.
*   **-t**: Tumor BAM file.
*   **-o**: Prefix for output files (generates `.msi` and `.msi_all`).

### 3. Tumor-Only Analysis (Matched-Normal-Free)
This is the preferred method when matched normal samples are unavailable. It requires a baseline.

**Step A: Build a Baseline**
Create a baseline from a set of normal samples (ideally >10-20 samples from the same sequencing platform/panel).

```bash
msisensor-pro baseline -d microsatellites.list -i normal_bam_list.txt -o baseline_output_dir
```
*   **-i**: A text file containing paths to multiple normal BAM files (one per line).

**Step B: Run MSI Detection**
```bash
msisensor-pro pro -d microsatellites.list -t tumor.bam -b baseline_file -o output_prefix
```
*   **-b**: The baseline file generated in the previous step.

## Expert Tips and Best Practices

*   **BAM Indexing**: Ensure all BAM files are indexed (`samtools index`) before running msisensor-pro.
*   **Consistency**: Always use the exact same reference genome FASTA for the `scan` step that was used for aligning the BAM files.
*   **Targeted Panels**: For panel sequencing, you can provide a BED file using the `-j` parameter to restrict analysis to the captured regions, which significantly speeds up processing.
*   **Thresholding**: While the default MSI score threshold is often 20%, this can vary by cancer type and sequencing depth. It is recommended to validate the threshold using known MSI-H and MSS samples for your specific assay.
*   **Coverage**: MSI detection is sensitive to sequencing depth. Ensure the microsatellite sites have sufficient coverage (typically >20x) for reliable scoring. Use the `-c` parameter to set a minimum coverage threshold for sites.

## Reference documentation
- [MSIsensor-pro GitHub Repository](./references/github_com_xjtu-omics_msisensor-pro.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_msisensor-pro_overview.md)