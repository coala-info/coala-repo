---
name: cagee
description: CAGEE (Computational Analysis of Gene Expression Evolution) provides a statistical framework for making evolutionary inferences from transcriptomic data.
homepage: https://github.com/hahnlab/CAGEE
---

# cagee

## Overview

CAGEE (Computational Analysis of Gene Expression Evolution) provides a statistical framework for making evolutionary inferences from transcriptomic data. Unlike standard differential expression tools, CAGEE incorporates a user-specified phylogenetic tree to model how expression levels change over time. It is primarily used to identify significant shifts in gene expression across clades, estimate the rate of expression evolution, and reconstruct the distribution of expression counts at ancestral nodes.

## Installation

Install the package via Bioconda:

```bash
conda install -c bioconda cagee
```

## Core Usage Patterns

### Basic Analysis
To run a standard analysis, you typically provide a phylogenetic tree and a gene expression data file. The tool models expression changes across the tree branches.

### Advanced Modeling Flags
Based on recent updates (v1.2+), use these specific parameters to refine the evolutionary model:

- **Free Rate Models**: Use `free_rate=global` to apply a global free rate model across the tree.
- **Optimization**: Use `optimizer_iterations=<int>` (formerly `neldermead_iterations`) to control the convergence of the likelihood optimization. For global free rates, a minimum of 3 iterations is recommended for stability.
- **Unbounded Ratios**: Use the `unbounded` flag (which replaced the previous `ratio` flag) when modeling specific expression ratio constraints.
- **Logging**: Use `log_config=<path>` to specify a custom logging configuration for debugging complex runs.

## Best Practices and Expert Tips

- **Tree Formatting**: Ensure your phylogenetic tree is in a standard format (like Newick) and that the leaf names exactly match the taxa identifiers in your expression data file.
- **Handling Missing Data**: CAGEE v1.2+ includes improved handling for missing values in replicate maps; however, minimizing missing data in your input matrix will improve the reliability of the $\sigma^2$ (sigma-squared) estimates.
- **Interpreting Results**: The primary output is written to `results.txt`. If other expected output files are missing, check the console log for optimization errors or "NaN" warnings, which suggest the model failed to converge on the provided data.
- **Node Identification**: When reviewing ancestral reconstructions, refer to the "ID's of Nodes" tree output to map internal node numbers back to specific clades in your phylogeny.
- **Model Selection**: If the global sigma-squared is not reported, it usually indicates that the specific model parameters provided (like clade-specific constraints) did not allow for a global calculation.

## Reference documentation

- [CAGEE GitHub Repository](./references/github_com_hahnlab_CAGEE.md)
- [CAGEE Main Commits and Version History](./references/github_com_hahnlab_CAGEE_commits_main.md)
- [Bioconda CAGEE Package Overview](./references/anaconda_org_channels_bioconda_packages_cagee_overview.md)