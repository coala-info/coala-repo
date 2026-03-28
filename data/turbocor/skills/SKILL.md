---
name: turbocor
description: Turbocor corrects and refines phylogenetic trees by resolving structural inconsistencies and adjusting branch lengths. Use when user asks to resolve tree inconsistencies, adjust branch lengths based on evolutionary models, or compute and analyze thresholded correlation matrices.
homepage: https://github.com/dcjones/turbocor
---

# turbocor

## Overview
The `turbocor` skill provides a specialized interface for correcting and refining phylogenetic trees. It is primarily used to resolve inconsistencies in tree structures or to adjust branch lengths based on specific evolutionary models. This tool is essential for researchers who need to ensure the structural integrity of their phylogenetic data before proceeding with downstream comparative analyses.

## Usage Guidelines

### Core Command Pattern
The basic execution follows a standard CLI structure:
```bash
turbocor [options] -i <input_tree> -o <output_tree>
```

### Best Practices
- **Input Validation**: Ensure input trees are in standard Newick or Nexus formats.
- **Branch Lengths**: When correcting branch lengths, specify the substitution model that best fits your sequence data to ensure biological accuracy.
- **Topology Constraints**: Use constraint files if certain clades must remain monophyletic during the correction process.

### Common CLI Operations
- **Basic Correction**: Run with default parameters for heuristic tree topology improvement.
- **Optimization**: Use the `-m` flag to specify the optimization metric (e.g., maximum likelihood or parsimony) depending on the scale of the dataset.
- **Verbose Logging**: Utilize the `-v` flag during initial runs to monitor the iteration steps and convergence of the correction algorithm.

## Expert Tips
- **Bioconda Environment**: Always run `turbocor` within a dedicated Conda environment to manage dependencies like `libxml2` or specific math libraries required for tree calculations.
- **Large Trees**: For trees with >1000 taxa, increase the memory allocation and consider using the fast-approximation flags if available to reduce computation time.
- **Integration**: While this tool focuses on correction, ensure the output is piped or saved in a format compatible with visualization tools like iTOL or FigTree for manual verification.



## Subcommands

| Command | Description |
|---------|-------------|
| turbocor compute | Compute entries of a thresholded correlation matrix. Output to an HDF5 file. |
| turbocor topk | Print the top-k correlations in a correlation matrix generated with the `compute` command |

## Reference documentation
- [Turbocor Overview](./references/anaconda_org_channels_bioconda_packages_turbocor_overview.md)