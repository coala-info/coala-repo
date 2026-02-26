---
name: clumppling
description: Clumppling aligns cluster labels across multiple runs of clustering algorithms to ensure consistency in population genetics results. Use when user asks to align clustering replicates, resolve label switching problems, identify consensus modes, or track cluster changes across different K-values.
homepage: https://pypi.org/project/clumppling
---


# clumppling

## Overview
Clumppling (CLUster Matching and Permutation Program with integer Linear programmING) provides a robust framework for the "label switching" problem in population genetics. When researchers run clustering algorithms multiple times, the cluster labels (e.g., Cluster 1, Cluster 2) are often inconsistent across runs. This tool automates the alignment of these results to ensure consistency across different K-values or replicates, utilizing ILP to find the most efficient mapping between clusters.

## Usage Guidelines

### Installation
The tool is primarily distributed via Bioconda and PyPI.
```bash
# Via Conda
conda install bioconda::clumppling

# Via Pip
pip install clumppling
```

### Core Workflow
1. **Input Preparation**: Ensure your clustering output files (Q-matrices) are formatted correctly. Clumppling typically expects membership coefficient matrices where rows are individuals and columns are clusters.
2. **Alignment**: Use the tool to align replicates of the same K-value to identify the "major mode" or consensus clustering.
3. **Cross-K Alignment**: Align results across different values of K to track how clusters split or merge as the model complexity increases.

### Best Practices
- **Mode Detection**: Use clumppling to identify distinct "modes" in your data—different but stable clustering solutions that appear across multiple runs.
- **ILP Efficiency**: For very large datasets or high K-values, ensure your environment has sufficient memory, as integer linear programming can be computationally intensive.
- **Visualization**: After alignment, use the permuted matrices to generate consistent bar plots where colors represent the same ancestral components across all figures.

## Reference documentation
- [Clumppling PyPI Project](./references/pypi_org_project_clumppling.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_clumppling_overview.md)