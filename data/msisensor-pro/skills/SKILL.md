---
name: msisensor-pro
description: MSIsensor-pro quantifies microsatellite instability by analyzing polymerase slippages in sequencing data using a multinomial distribution model. Use when user asks to scan a reference genome for microsatellites, perform paired tumor-normal MSI analysis, conduct tumor-only MSI detection, or build a baseline from normal samples.
homepage: https://github.com/xjtu-omics/msisensor-pro
---

# msisensor-pro

## Overview

MSIsensor-pro is a high-performance tool designed to quantify Microsatellite Instability (MSI) by analyzing polymerase slippages through a multinomial distribution model. It is an evolution of the original msisensor, optimized for speed and accuracy. Its primary advantage is the ability to perform MSI detection without a matched normal sample by using a discriminative sites selection method and a pre-built baseline.

## Core Workflows

### 1. Reference Genome Scanning
Before analyzing samples, scan the reference genome to identify microsatellite sites. This is a one-time setup for each reference version (e.g., hg19, hg38).

```bash
msisensor-pro scan -d reference.fasta -o microsatellites.list
```
*   **Tip**: Use default parameters for general use. Adjust `-l` (minimal homopolymer size) or `-s` (maximal microsatellite unit length) only for specific panel requirements.

### 2. Paired Tumor-Normal Analysis
Use this standard workflow when both tumor and matched normal BAM/CRAM files are available.

```bash
msisensor-pro msi -d microsatellites.list -n normal.bam -t tumor.bam -o output_prefix
```
*   **Coverage**: Default coverage threshold is 15. For WXS, increase to `-c 20`.
*   **CRAM Files**: If using CRAM, the reference genome must be provided via `-g`.
*   **Parallelization**: Use `-b [int]` to specify threads for faster processing.

### 3. Tumor-Only Analysis (Pro)
Use this workflow for samples lacking a matched normal. This requires a baseline (see below).

```bash
msisensor-pro pro -d microsatellites.list -t tumor.bam -o output_prefix
```
*   **Threshold**: The `-i` parameter sets the instability threshold (default 0.1).

### 4. Building a Baseline
To perform tumor-only analysis effectively, build a baseline using a collection of normal samples (ideally >10).

1.  Run the `pro` command on each normal sample individually.
2.  Create a configuration text file listing case names and paths to the `_all` output files:
    ```text
    case1 /path/to/case1_all
    case2 /path/to/case2_all
    ```
3.  Generate the baseline:
    ```bash
    msisensor-pro baseline -d microsatellites.list -i config.txt -o baseline_output_path
    ```

## Expert Tips and Best Practices

*   **Output Paths**: Never end the output path (`-o`) with a slash, as the tool appends suffixes to the prefix provided.
*   **Memory Management**: While fast, scanning large genomes or processing high-depth WGS data can be memory-intensive. Ensure adequate RAM when using high thread counts (`-b`).
*   **Site Selection**: For targeted panels, ensure the `microsatellites.list` is filtered to the panel's regions to reduce computational overhead and false positives from off-target reads.
*   **Homopolymer Focus**: If only interested in homopolymers (repeat unit = 1), use the `-x 1` flag in `msi` or `pro` commands to simplify output.
*   **Quality Control**: In the `baseline` command, use `-s` to filter out microsatellite sites with low support across your normal sample cohort (default is 10 samples).



## Subcommands

| Command | Description |
|---------|-------------|
| msisensor-pro | Microsatellite Instability (MSI) detection using high-throughput sequencing data. (Support tumor-normal paired samples and tumor-only samples) |
| msisensor-pro | Microsatellite Instability (MSI) detection using high-throughput sequencing data. (Support tumor-normal paired samples and tumor-only samples) |
| msisensor-pro | Microsatellite Instability (MSI) detection using high-throughput sequencing data. (Support tumor-normal paired samples and tumor-only samples) |
| msisensor-pro baseline | This module build baseline for MSI detection with pro module using only tumor sequencing data. To achieve it, you need sequencing data from normal samples(-i). |
| msisensor-pro msi | This module evaluate MSI using the difference between normal and tumor length distribution of microsatellites. You need to input (-d) microsatellites file and two bam files (-t, -n). |
| msisensor-pro pro | This module evaluate MSI using single (tumor) sample. You need to input (-d) microsatellites file and a bam files (-t) . |
| msisensor-pro scan | This module scan the reference genome to get microsatellites information. You need to input (-d) a reference file (*.fa or *.fasta), and you will get a microsatellites file (-o) for following analysis. If you use GRCh38.d1.vd1 , you can download the file on out github directly. |

## Reference documentation

- [Main commands of MSIsensor-pro](./references/github_com_xjtu-omics_msisensor-pro_blob_master_docs_4_command.md)
- [MSIsensor-pro README](./references/github_com_xjtu-omics_msisensor-pro_blob_master_README.md)
- [Installation and Dependencies](./references/github_com_xjtu-omics_msisensor-pro_blob_master_docs_3_Installation.md)