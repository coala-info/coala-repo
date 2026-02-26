---
name: ifcnv
description: ifCNV identifies genomic amplifications and deletions in targeted sequencing data using an Isolation Forest machine learning algorithm. Use when user asks to detect copy number variations, identify genomic outliers, or analyze read-depth distribution in capture and amplicon-based panels.
homepage: https://github.com/SimCab-CHU/ifCNV
---


# ifcnv

## Overview
ifCNV (Isolation Forest based Copy Number Variation detection) is a machine learning tool designed to identify genomic amplifications and deletions based on read-depth distribution. It utilizes the Isolation Forest algorithm to perform a two-stage detection process: first, it identifies "outlier" samples with significant read-depth bias; second, it identifies specific altered targets within those samples by comparing them to a dynamically generated normal reference. The tool is specifically optimized for targeted sequencing data, such as capture or amplicon-based panels.

## Command Line Usage

### Basic Execution
To run a standard analysis on a directory of BAM files:
```bash
ifCNV -i /path/to/bam/directory/ -b /path/to/bed/file -o /path/to/output/directory/
```

### Optimization and Iteration
Creating the read-depth matrix is the most time-consuming step. If you need to re-run the analysis with different thresholds (e.g., changing the score threshold), export the matrix first and then skip the pre-processing in subsequent runs.

1. **First run (Export matrix):**
   ```bash
   ifCNV -i ./bams/ -b targets.bed -o ./results/ -rm ./results/reads_matrix.tsv
   ```

2. **Subsequent runs (Skip matrix creation):**
   ```bash
   ifCNV -i ./bams/ -b targets.bed -o ./results/ -s ./results/reads_matrix.tsv -sT 0.5
   ```

### Key Parameters
- `-m, --mode`: Choose between `fast` or `extensive`. Use `extensive` for higher sensitivity at the cost of computation time.
- `-sT, --scoreThreshold`: Adjust the localization score threshold to filter significant regions.
- `-min, --minReads`: Set the minimum mean reads per target to filter out low-coverage regions that might produce noise.
- `-rS, --regSample`: Provide a regex pattern to exclude specific control samples from the CNV detection logic.
- `-rT, --regTargets`: Provide a regex pattern to exclude specific targets (e.g., off-target regions or problematic probes).

## Best Practices and Expert Tips

### BED File Requirements
The 4th column of your BED file is critical. ifCNV uses this column (typically the gene name or region identifier) to group targets and calculate the localization score. Ensure this column is consistently labeled to get accurate per-region results.

### Sample Size
While the tool requires a minimum of three samples, the Isolation Forest algorithm's performance improves significantly with larger cohorts. For small runs, ensure the samples are processed with the same library preparation and sequencing parameters to minimize batch effects.

### Interpreting the HTML Report
- **Reads Ratio > 2**: High-level amplification.
- **1 < Reads Ratio < 2**: Gain.
- **Reads Ratio < 1**: Loss/Deletion.
The localization score indicates the statistical confidence of the alteration within that specific region. Clicking on entries in the HTML report provides a visual log-ratio plot for target-level inspection.

### Silent Execution
For integration into automated pipelines where GUI interaction is not possible, disable the automatic report opening and verbosity:
```bash
ifCNV -i ./input -b ./targets.bed -o ./output -a ' ' -v ' '
```

## Reference documentation
- [ifCNV GitHub Repository](./references/github_com_SimCab-CHU_ifCNV.md)
- [ifCNV Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ifcnv_overview.md)