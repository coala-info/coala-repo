---
name: tbpore
description: tbpore is a bioinformatics pipeline for analyzing Mycobacterium tuberculosis Nanopore sequencing data through read decontamination, variant calling, and drug susceptibility prediction. Use when user asks to process raw TB reads, predict drug resistance, or perform genomic clustering for epidemiological investigations.
homepage: https://github.com/mbhall88/tbpore/
---


# tbpore

## Overview
`tbpore` is a specialized bioinformatics pipeline designed to simplify the genomic analysis of *Mycobacterium tuberculosis* (TB) from Nanopore sequencing data. It automates the transition from raw reads to actionable insights by performing read decontamination, variant calling relative to the canonical H37Rv strain, and drug susceptibility testing (DST) prediction. It also includes utilities for genomic clustering, which is essential for identifying transmission chains and supporting epidemiological investigations.

## Core Workflows

### 1. Initial Setup
Before processing any samples, you must download the required decontamination database index.
```bash
tbpore download
```
*Tip: By default, this saves to `~/.tbpore/decontamination_db/`. If you use a custom path with `-o`, you must provide that path via the `--db` flag during processing.*

### 2. Single-Sample Processing
The `process` command is the primary tool for analyzing raw FASTQ data. It decontaminates reads, calls variants with `bcftools`, and predicts resistance with `mykrobe`.
```bash
tbpore process -S SampleName -o ./output_dir/ /path/to/fastq/
```
**Common CLI Patterns:**
- **Recursive Input**: Use `-r` to search through subdirectories for FASTQ files.
- **Subsampling**: Use `-c <int>` (e.g., `-c 50`) to subsample reads to a specific depth. This is highly recommended for consistent performance across samples with varying throughput.
- **Performance**: Use `-t` to specify the number of threads for multithreaded components like `minimap2`.
- **Full Reporting**: Use `-A` to ensure `mykrobe` reports all calls, not just those meeting default confidence thresholds.

### 3. Sample Clustering
After processing multiple samples, use the `cluster` command to identify genetic relationships. This command typically takes the `.consensus.fa` files produced by the `process` step.
```bash
tbpore cluster -T 6 -o ./clustering/ output/sample_*/*.consensus.fa
```
- **Thresholding**: The `-T` flag sets the SNP distance threshold. The default is 6, but this can be adjusted based on the specific requirements of the outbreak investigation.

## Expert Tips and Best Practices
- **Input Handling**: `tbpore` joins all provided input FASTQ files into a single analysis. Ensure that all files passed in a single `process` command represent the same isolate.
- **Disk Space Management**: The pipeline generates significant intermediate data. Use the `-d` or `--cleanup` flag to automatically remove temporary files after a successful run.
- **Temporary Files**: If working on a cluster or a system with limited home directory space, use `--tmp` to redirect intermediate file writing to a high-capacity scratch partition.
- **Version Consistency**: The tool is sensitive to dependency versions, particularly `bcftools`. When running in custom environments, ensure `bcftools` is version 1.13 as recommended by the developers for optimal variant calling performance.

## Reference documentation
- [TBpore GitHub Repository](./references/github_com_mbhall88_tbpore.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_tbpore_overview.md)