---
name: pyfish
description: Pyfish is a Python-based utility for generating Muller plots to visualize evolutionary trajectories and clonal hierarchies over time. Use when user asks to create Muller plots, visualize clonal evolution, or plot population frequency data with phylogenetic relationships.
homepage: https://bitbucket.org/schwarzlab/pyfish
---


# pyfish

## Overview
The `pyfish` tool is a specialized Python-based utility for generating Muller plots (also known as Fish plots). These visualizations are essential for interpreting complex evolutionary trajectories, as they represent both the frequency of specific clones/populations and their phylogenetic relationships (parent-child nesting) across multiple time points. This skill provides the necessary command-line patterns to transform population frequency data into publication-quality evolutionary diagrams.

## Core Workflow and Data Requirements
To use `pyfish` effectively, you must provide two primary inputs:
1.  **Frequency Data**: A table (typically CSV or TSV) containing the proportions of each clone at every sampled time point.
2.  **Adjacency/Topology Data**: A definition of the clonal hierarchy (which clone emerged from which parent).

### Common CLI Patterns
The basic execution follows this structure:
```bash
pyfish --input frequencies.csv --topology structure.csv --output muller_plot.pdf
```

### Expert Tips for High-Quality Plots
- **Time Interpolation**: If your sampling points are sparse, use the smoothing or interpolation flags (if available in the specific version) to avoid jagged transitions between time points.
- **Color Mapping**: For complex trees with many subclones, manually define a color palette in a configuration file to ensure that related lineages share similar hues, making the nesting easier to follow visually.
- **Normalization**: Ensure that the sum of frequencies at any given time point does not exceed 1.0 (100%), as `pyfish` relies on this for accurate area stacking.

## Troubleshooting and Best Practices
- **Zero-Frequency Handling**: Ensure clones that have gone extinct are explicitly marked with `0` in the frequency file for the remaining time points to prevent "floating" polygons.
- **Nesting Logic**: Double-check the topology file; a clone cannot have more than one parent. If a lineage appears to have multiple origins, it must be split into distinct clonal IDs.

## Reference documentation
- [pyfish Bitbucket Repository](./references/bitbucket_org_schwarzlab_pyfish.md)
- [Bioconda pyfish Overview](./references/anaconda_org_channels_bioconda_packages_pyfish_overview.md)