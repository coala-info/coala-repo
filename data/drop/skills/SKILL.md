---
name: drop
description: The Detection of RNA Outlier Pipeline (DROP) identifies rare aberrant expression, splicing, and mono-allelic expression events in RNA-sequencing data to help diagnose rare disorders. Use when user asks to detect RNA outliers, identify aberrant splicing or expression, perform mono-allelic expression analysis, or run a standardized diagnostic workflow for rare diseases.
homepage: https://github.com/gagneurlab/drop
---


# drop

## Overview

The Detection of RNA Outlier Pipeline (DROP) is a specialized bioinformatic workflow designed to identify rare aberrant events in RNA-sequencing data. It integrates three primary modules—aberrant expression (using OUTRIDER), aberrant splicing (using FRASER), and mono-allelic expression (MAE)—to help researchers and clinicians diagnose rare disorders. By automating the transition from raw data to diagnostic reports, DROP provides a standardized framework for detecting outliers that may indicate pathogenic variants.

## Installation and Setup

To ensure a stable environment, use Mamba or Conda to install DROP from the bioconda channel.

```bash
# Create a dedicated environment
mamba create -n drop_env -c conda-forge -c bioconda drop --override-channels

# Activate the environment
conda activate drop_env
```

## Common CLI Patterns

DROP utilizes Snakemake as its underlying execution engine. All pipeline commands should be run from within your initialized project directory.

### Project Initialization
To explore the pipeline structure, you can generate a demo project.
```bash
mkdir ~/drop_demo
cd ~/drop_demo
drop demo
```

### Execution Commands
Always perform a dry run before full execution to verify the rule graph and pending tasks.
```bash
# Dry run
snakemake -n

# Execute the full pipeline
snakemake --cores 10

# Execute specific modules
snakemake aberrantExpression --cores 10
snakemake aberrantSplicing --cores 10
snakemake mae --cores 10
snakemake rnaVariantCalling --cores 10
```

## Expert Tips and Best Practices

### Handling Snakemake Versioning
If using Snakemake v7.8 or later, certain rules may trigger unnecessarily due to metadata changes. Use the following flag to prevent redundant executions:
```bash
snakemake --cores 10 --rerun-triggers mtime
```

### Performance Optimization (v1.5.0+)
Version 1.5.0 introduced the "Optimal Hard Threshold" (OHT) procedure for OUTRIDER and FRASER. This deterministic approach replaces the previous grid search for autoencoder dimensions, reducing runtime by 6–10 times. Ensure your configuration enables OHT to benefit from these speedups.

### Mixing Input Types
DROP supports mixing BAM files and external expression counts within the same group. 
- If both are provided for a sample, external counts take priority for expression analysis.
- BAM files will still be utilized for splicing analysis even if external counts are used for expression.

### Splicing Metrics
When using the aberrant splicing module, you can choose between FRASER 1.0 (Percent Spliced In) and FRASER 2.0 (Intron Jaccard Index). Switching to FRASER 2.0 requires updating the `FRASER_version` parameter and adjusting `quantileForFiltering` and `deltaPsiCutoff` in your configuration.

### Memory Management
For large cohorts, splicing analysis can be memory-intensive. It is recommended to run the pipeline on a high-performance computing (HPC) cluster and specify memory constraints per rule if necessary.

## Reference documentation
- [DROP GitHub Repository](./references/github_com_gagneurlab_drop.md)
- [Bioconda DROP Overview](./references/anaconda_org_channels_bioconda_packages_drop_overview.md)