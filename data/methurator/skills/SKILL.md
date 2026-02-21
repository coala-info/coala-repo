---
name: methurator
description: Methurator is a specialized bioinformatics tool designed to assess the saturation of CpG site discovery in DNA methylation experiments.
homepage: https://github.com/VIBTOBIlab/methurator
---

# methurator

## Overview
Methurator is a specialized bioinformatics tool designed to assess the saturation of CpG site discovery in DNA methylation experiments. By analyzing aligned sequencing data (BAM files), it calculates the relationship between sequencing depth and the number of unique CpG sites detected. It employs statistical estimators to extrapolate discovery curves beyond the observed data, helping researchers determine the "completeness" of their library and predict how many additional sites would be found with deeper sequencing.

## Installation
The recommended way to install methurator is via Bioconda:
```bash
conda create -n methurator_env methurator
conda activate methurator_env
```

## Core Workflow

### 1. Estimating Saturation
The primary command for calculating saturation metrics is `gt-estimator`. This command processes the BAM file and produces a summary of observed and predicted CpG discovery.

```bash
# Basic estimation
methurator gt-estimator --genome hg38 sample.bam

# Estimation with bootstrap confidence intervals
methurator gt-estimator --genome hg19 --compute_ci sample.bam
```

**Key Arguments:**
- `--genome`: (Required) Specify the reference genome build (e.g., hg19, hg38, mm10).
- `--compute_ci`: Enables bootstrap confidence intervals for the saturation curve.
- `input.bam`: The aligned reads file (positional argument).

### 2. Generating Visualizations
Once the estimation is complete, use the `plot` command to generate interactive HTML reports. This command uses the summary file generated in the previous step to avoid re-calculating the saturation curve.

```bash
methurator plot --summary output/methurator_summary.yml
```

## Expert Tips and Best Practices
- **Efficiency**: Always use the `methurator plot` command with the `.yml` summary file rather than re-running the estimator on the raw BAM file. The summary file contains all necessary metadata and pre-calculated points for the curve.
- **Genome Consistency**: Ensure the `--genome` flag matches the reference used during the alignment of your BAM file to avoid incorrect CpG site mapping.
- **Positional Arguments**: In recent versions (v0.1.7+), BAM input files are treated as positional arguments.
- **Reproducibility**: The `methurator_summary.yml` file includes tool versioning, run dates, and the specific options used, making it the primary asset for documenting the analysis pipeline.
- **Progress Tracking**: The tool uses dynamic progress bars; when running in headless environments or logs, be aware that these may generate significant stdout noise unless piped or silenced.

## Reference documentation
- [methurator - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_methurator_overview.md)
- [GitHub - VIBTOBIlab/methurator](./references/github_com_VIBTOBIlab_methurator.md)
- [Tags · VIBTOBIlab/methurator](./references/github_com_VIBTOBIlab_methurator_tags.md)