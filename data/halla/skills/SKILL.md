---
name: halla
description: HAllA is a statistical framework that discovers associations between two high-dimensional datasets using hierarchical clustering and correlation testing. Use when user asks to find associations between datasets, identify correlations between clusters of features, or generate a hallagram to visualize complex biological relationships.
homepage: http://huttenhower.sph.harvard.edu/halla
---


# halla

## Overview
HAllA is a statistical framework for discovering associations between two high-dimensional datasets. Unlike standard all-against-all correlation tests, HAllA uses a hierarchical approach: it clusters features in both datasets, tests for associations between clusters, and then drills down to find specific feature-level associations. This method increases statistical power and provides a more organized view of complex biological relationships.

## Usage Guidelines

### Basic Command Structure
The primary interface is the `halla` command. A typical execution requires two input files (feature tables) and an output directory.

```bash
halla -x dataset_a.txt -y dataset_b.txt -o output_directory
```

### Input Requirements
- **Format**: Tab-separated (.tsv) or comma-separated (.csv) files.
- **Structure**: Features as rows and samples as columns (or vice versa, ensure consistency).
- **Normalization**: Ensure data is appropriately normalized (e.g., TSS for microbial abundances) before running HAllA.

### Key Parameters and Optimization
- **Similarity Measures**: Choose the metric that best fits your data type using `-m` or `--metric`.
    - `spearman` or `pearson`: For continuous/numeric data.
    - `nmi` (Normalized Mutual Information): For categorical or non-linear relationships.
- **Discretization**: If using NMI on continuous data, HAllA will discretize the data. Control this with `--discretize`.
- **Permutations**: Use `-p` to set the number of permutations for p-value calculation. Higher values (e.g., 1000) increase precision but extend runtime.
- **FDR Control**: Adjust the significance threshold with `--alpha` (default is usually 0.05).

### Interpreting Outputs
HAllA produces several key files in the output directory:
- `associations.txt`: The primary list of significant associations found.
- `clusters_x.txt` / `clusters_y.txt`: The hierarchical clustering results for each dataset.
- `hallagram.pdf/png`: A visual representation (heatmap) of the discovered associations and clusters.

## Best Practices
- **Filtering**: Remove low-variance or extremely sparse features before running HAllA to reduce computational overhead and noise.
- **Diagnostics**: Check the `hallagram` first to identify broad patterns of association before diving into individual feature pairs.
- **Consistency**: Ensure that sample IDs match exactly between the `-x` and `-y` input files.

## Reference documentation
- [HAllA Overview](./references/anaconda_org_channels_bioconda_packages_halla_overview.md)