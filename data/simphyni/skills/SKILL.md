---
name: simphyni
description: SimPhyNI detects associations between binary traits by accounting for phylogenetic structure through evolutionary simulations. Use when user asks to infer trait associations, detect genotype-phenotype relationships, or perform phylogenetically-corrected trait analysis.
homepage: https://github.com/jpeyemi/SimPhyNI
---


# simphyni

## Overview
SimPhyNI (Simulation-based Phylogenetic iNteraction Inference) is a specialized tool for evolutionary biology that detects associations between binary traits while accounting for the underlying phylogenetic structure of the samples. Unlike standard association tests that treat samples as independent, SimPhyNI uses the phylogenetic tree to infer evolutionary parameters (gain/loss rates) and generates null models through independent simulations. This approach ensures that detected associations are likely due to functional or evolutionary relationships rather than simple inheritance from a common ancestor.

## Installation and Setup
The tool is primarily distributed via Bioconda. Ensure your conda channels are configured with `conda-forge` and `bioconda` before installing.

```bash
# Installation
conda create -n simphyni simphyni
conda activate simphyni

# Verify installation
simphyni version
```

## Input Requirements
SimPhyNI requires two primary input files:
1.  **Phylogenetic Tree (`.nwk`)**: Must be in Newick format and rooted (midpoint or outgroup). Branch lengths are mandatory for rate estimation. Tip labels must exactly match the sample names in the traits file.
2.  **Traits File (`.csv`)**: A comma-separated file where the first column contains sample names. Subsequent columns should contain binary data (0 for absent, 1 for present).

## Common CLI Patterns

### Single-Run Analysis
Use this mode to compare specific traits against others in a single dataset.

```bash
simphyni run \
  --sample-name my_analysis \
  --tree species_tree.nwk \
  --traits binary_traits.csv \
  --run-traits 0,1,5 \
  --outdir results/ \
  --cores 4 \
  --plot
```
*   `--run-traits`: 0-indexed column indices for "trait-against-all" comparisons. Use `ALL` to test every trait pair.
*   `--plot`: Generates heatmap summaries of the associations.

### Batch Processing
For multiple datasets, create a `samples.csv` containing columns for `Sample`, `Tree`, and `Traits`.

```bash
simphyni run --samples samples.csv --cores 16
```

### High-Performance Computing (HPC)
SimPhyNI integrates with Snakemake profiles for cluster execution (e.g., SLURM).

```bash
# Download necessary cluster configuration templates
simphyni download-cluster-scripts

# Run using a specific cluster profile
simphyni run --samples samples.csv --profile cluster_profile
```

## Expert Tips and Best Practices
*   **P-value Selection**: 
    *   Use `pval_bh` (Benjamini-Hochberg) for phenotype-genotype associations.
    *   Use `pval_by` (Benjamini-Yekutieli) for genotype-genotype associations, as it is more robust to dependencies between tests.
*   **Prevalence Filtering**: Use `--min_prev` and `--max_prev` (default 0.05 to 0.95) to exclude traits that are too rare or too ubiquitous to provide statistical power.
*   **Memory Management**: Avoid using the `--save-object` flag for large-scale analyses (over 1,000,000 comparisons) to prevent excessive memory usage and large `.pkl` file sizes.
*   **Upstream Processing**: If you only have raw FASTA files, consider using the companion pipeline `SimPhyNI-Prelude` to generate the required tree and pangenome matrix before running SimPhyNI.

## Reference documentation
- [SimPhyNI GitHub Repository](./references/github_com_jpeyemi_SimPhyNI.md)
- [SimPhyNI Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_simphyni_overview.md)