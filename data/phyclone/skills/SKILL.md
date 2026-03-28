---
name: phyclone
description: PhyClone reconstructs cancer phylogenies and infers clonal relationships from bulk sequencing data using a Bayesian framework. Use when user asks to reconstruct tumor evolutionary trees, infer cancer cell populations, or generate consensus phylogenies from mutation and copy number data.
homepage: https://github.com/Roth-Lab/PhyClone
---


# phyclone

## Overview
PhyClone is a specialized tool designed to reconstruct cancer phylogenies using a forest-structured Chinese restaurant process. It provides a Bayesian framework to infer the relationship between different cell populations (clones) within a tumor based on bulk sequencing data. By integrating mutation counts and copy number profiles, it generates posterior distributions of tree topologies, allowing researchers to identify the most likely evolutionary paths (MAP trees) or consensus structures.

## Installation and Setup
The most reliable way to install PhyClone is via Bioconda:

```bash
conda create --name phyclone -c bioconda -c conda-forge phyclone
conda activate phyclone
```

## Input Preparation
PhyClone requires a tab-delimited (TSV) file with specific columns. Ensure your data is in "tidy" format.

### Main Input File (`--input`)
Required columns:
- `mutation_id`: Unique identifier (must match across samples).
- `sample_id`: Unique identifier for the sample.
- `ref_counts`: Number of reference allele reads.
- `alt_counts`: Number of alternate allele reads.
- `major_cn`: Major copy number (must be > 0).
- `minor_cn`: Minor copy number.
- `normal_cn`: Total copy number in healthy tissue (usually 2 for autosomes).

### Cluster File (`--clusters`)
While optional, pre-clustering mutations (e.g., using PyClone-VI) is highly recommended for Whole Genome Sequencing (WGS) data to reduce computational complexity.
- Required: `mutation_id`, `cluster_id`.
- Recommended for data-informed priors: `sample_id`, `chrom`, `cellular_prevalence`.

## Command Line Usage

### Running the Sampler
The primary command is `phyclone run`. It is recommended to run multiple chains in parallel for better convergence.

```bash
phyclone run -i data.tsv -c clusters.tsv -o trace.h5 --num-chains 4 --num-particles 100
```

### Key Parameters and Best Practices
- **Parallelization**: Use `--num-chains 4` (or more) if compute resources allow.
- **Sampling Depth**: Use `-n` to set the number of iterations and `-b` for burn-in iterations.
- **Complexity**: For complex subclonal structures, increase `--num-particles` beyond the default 100. This improves the SMC (Sequential Monte Carlo) approximation at a minor computational cost.
- **Reproducibility**: Always set a `--seed` when generating final results for publication.
- **Data Cleaning**: PhyClone automatically removes mutations with `major_cn` of 0 or those missing data in any sample. Ensure your BAM-derived counts are complete across all samples before running.

## Output Analysis
The output `trace.h5` file contains the sampled topologies. Use the summary sub-commands (MAP or Consensus) to generate point-estimate trees from the trace.



## Subcommands

| Command | Description |
|---------|-------------|
| phyclone consensus | Build consensus results. |
| phyclone_map | Build MAP results. |
| phyclone_topology-report | Build topology report. |
| run | Run a new PhyClone analysis. |

## Reference documentation
- [PhyClone GitHub README](./references/github_com_Roth-Lab_PhyClone_blob_main_README.md)
- [PhyClone Overview](./references/anaconda_org_channels_bioconda_packages_phyclone_overview.md)