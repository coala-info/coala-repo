---
name: msisensor2
description: "MSIsensor2 uses machine learning to detect microsatellite instability (MSI) in tumor-only sequencing data without requiring a paired normal sample. Use when user asks to calculate MSI scores, identify somatic microsatellite sites, or determine MSI status from tumor BAM files."
homepage: https://github.com/niu-lab/msisensor2
---


# msisensor2

## Overview
MSIsensor2 is a machine-learning-based upgrade to the original MSIsensor, specifically optimized for MSI detection without a paired normal sample. It evaluates the distribution of microsatellites using pre-trained models to calculate an MSI score (percentage of somatic sites). It is highly efficient, capable of processing WES data in under three minutes, and supports various sample types including liquid biopsies (cfDNA) with tumor content as low as 0.1%.

## Command Line Usage

The primary command for analysis is `msi`.

### Basic Syntax
```bash
msisensor2 msi -M <models_directory> -t <tumor_bam> -o <output_prefix>
```

### Key Options
- `-M <string>`: **Required.** Path to the directory containing machine learning models. You must match the model to your reference genome (e.g., `models_hg38`, `models_hg19_GRCh37`, or `models_b37_HumanG1Kv37`).
- `-t <string>`: **Required.** Path to the tumor BAM file. The BAM index (`.bai`) must be present in the same directory.
- `-o <string>`: **Required.** Prefix for the three output files.
- `-c <int>`: Coverage threshold for a site to be included in analysis. 
    - Recommended for **WXS/Panel**: `20` (default)
    - Recommended for **WGS**: `15`
- `-b <int>`: Number of threads for parallel computing (default is 1).
- `-x <int>`: Output homopolymer sites only (0: no, 1: yes).
- `-y <int>`: Output microsatellite sites only (0: no, 1: yes).

## Best Practices and Interpretation

### Model Selection
Ensure you use the model directory corresponding to the reference genome used for alignment:
- **hg38**: Use `models_hg38`
- **hg19/GRCh37**: Use `models_hg19_GRCh37`
- **b37/HumanG1Kv37**: Use `models_b37_HumanG1Kv37`

### Interpreting Results
The tool generates three output files:
1. `<prefix>`: Contains the final MSI score.
    - **MSI-High (MSI-H)**: MSI score ≥ 20% (recommended cutoff).
    - **Microsatellite Stable (MSS)**: MSI score < 20%.
2. `<prefix>_somatic`: Lists specific somatic sites detected with their machine learning discrimination values.
3. `<prefix>_dis`: Contains the read count distribution for each site.

### Performance Optimization
For Whole Exome Sequencing (WES) or Whole Genome Sequencing (WGS), always utilize the `-b` flag to increase thread count, as the tool supports efficient parallelization.



## Subcommands

| Command | Description |
|---------|-------------|
| msisensor scan | Scan for homopolymers and microsatellites in a reference genome. |
| msisensor2 msi | Calculate MSI score from BAM files |

## Reference documentation
- [MSIsensor2 GitHub Repository](./references/github_com_niu-lab_msisensor2.md)
- [MSIsensor2 README](./references/github_com_niu-lab_msisensor2_blob_master_README.md)