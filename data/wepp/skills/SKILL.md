---
name: wepp
description: WEPP (Wastewater-Based Epidemiology using Phylogenetic Placements) is a pathogen-agnostic pipeline designed to provide high-resolution insights into the composition of community wastewater samples.
homepage: https://github.com/TurakhiaLab/WEPP
---

# wepp

## Overview

WEPP (Wastewater-Based Epidemiology using Phylogenetic Placements) is a pathogen-agnostic pipeline designed to provide high-resolution insights into the composition of community wastewater samples. By leveraging mutation-annotated trees (MAT), it moves beyond simple marker-based detection to perform parsimonious read placement. This allows for the deconvolution of complex mixtures, accurate estimation of lineage proportions, and the flagging of alleles that do not match known haplotypes—potentially indicating the emergence of new variants.

## Installation and Setup

The recommended installation method is via Bioconda to ensure all phylogenetic dependencies are correctly managed.

```bash
# Create and configure environment
conda create --name wepp-env
conda activate wepp-env
conda config --env --add channels bioconda
conda config --env --add channels conda-forge
conda config --env --set channel_priority flexible

# Install WEPP
conda install wepp
```

## Common CLI Patterns

WEPP is built on Snakemake. The primary entry point is the `run-wepp` command.

### Basic Execution
To run the pipeline on your data, specify the number of cores and ensure conda integration is enabled for the internal workflow steps.

```bash
run-wepp --cores 8 --use-conda
```

### Optimization for Multiple Runs
When processing multiple datasets across different directories, use the `--conda-prefix` flag. This prevents the pipeline from recreating identical Snakemake environments for every run, saving significant time and disk space.

```bash
run-wepp --cores 8 --use-conda --conda-prefix /path/to/shared/snakemake_envs
```

### Docker Integration
If running via Docker, ensure you map the appropriate ports to access the interactive dashboard.

```bash
# Map container port 80 to host port 8080 for dashboard access
docker run -it -p 8080:80 -v "$PWD":/WEPP -w /WEPP pranavgangwar/wepp:latest
```

## Expert Tips and Best Practices

- **Pathogen Agnosticism**: While often used for SARS-CoV-2 or RSV-A, WEPP is pathogen-agnostic. To adapt it to a new pathogen, you must provide a corresponding Mutation-Annotated Tree (MAT).
- **Unaccounted Alleles**: Pay close attention to the "Unaccounted Alleles" report. These are mutations observed in your sample that cannot be explained by the selected haplotypes. High frequencies of unaccounted alleles often suggest the presence of a novel lineage or a sub-lineage not yet represented in your MAT.
- **Dashboard Visualization**: The interactive dashboard is the most effective way to validate parsimonious placements. It allows you to see exactly which reads were mapped to which haplotypes and identify the specific "residue" (unexplained mutations) at the read level.
- **Resource Allocation**: Because WEPP performs phylogenetic placement (which can be computationally intensive), always specify the `--cores` argument to match your hardware capabilities.
- **Troubleshooting**: If the pipeline fails during the environment creation phase, verify that your conda channels are prioritized correctly (conda-forge and bioconda should be at the top).

## Reference documentation
- [WEPP GitHub Repository](./references/github_com_TurakhiaLab_WEPP.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_wepp_overview.md)