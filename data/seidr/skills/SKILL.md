---
name: seidr
description: Seidr is a toolkit for gene network inference, aggregation, and exploration using a consensus-based approach. Use when user asks to infer gene networks, aggregate multiple network predictions, calculate network statistics, or prune networks via backbone estimation.
homepage: https://github.com/bschiffthaler/seidr
---


# seidr

## Overview
Seidr is a specialized toolkit for gene network inference and exploration. Its primary strength lies in the "wisdom of the crowd" approach, allowing users to aggregate multiple independent network predictions into a single, high-confidence consensus network. It provides a suite of tools for importing data from various inference methods, calculating network statistics, pruning networks via backbone estimation, and visualizing results.

## Installation
The package is available via Bioconda:
```bash
conda install -c bioconda seidr
```

## Common CLI Patterns

### Data Import
Convert external inference results (matrices or edge lists) into the seidr binary format:
```bash
# Import a matrix file
seidr import --matrix <input_file> --output <output.sf>
```
*Note: If your matrix contains all zeros, ensure you are using version 0.13.1 or later to avoid potential segmentation faults.*

### Network Aggregation and Filtering
Seidr is frequently used to filter and rank the most significant edges in a network:
```bash
# Get the top edges from a network
seidr top --input <network.sf> --output <top_network.sf>
```
*Tip: Use `seidr top` to handle ties and priority queue filling for large-scale networks.*

### Network Statistics and Centrality
Calculate node-level metrics such as centrality:
```bash
# Calculate network statistics
seidr stats --input <network.sf> --output <stats.txt>
```
*   **Directionality**: Experimental support for directionality is available in `seidr stats`.
*   **Scaling**: Scaling is enabled by default. Use the `--no-scale` flag if you wish to preserve raw values.

### Visualization and Inspection
To view the contents of the binary `.sf` files in a human-readable format:
```bash
# View network data
seidr view --input <network.sf>

# View centrality data in dense format
seidr view --input <centrality.sf> --dense
```

### Network Pruning
Use the backbone command to identify the most significant underlying structure of a network:
```bash
# Estimate the network backbone
seidr backbone --input <network.sf> --output <backbone.sf>
```

## Expert Tips
*   **SFT Cutoff**: When performing Scale-Free Topology (SFT) analysis, use the `-c` flag to specify the cutoff.
*   **Memory Management**: For very large networks, ensure you are using the latest version (0.14.2+) which includes fixes for priority queue filling and tie-handling in the `top` command.
*   **Output Handling**: Seidr tools are designed to flush output streams properly on exit, making them suitable for inclusion in automated bioinformatics pipelines.

## Reference documentation
- [Seidr GitHub Repository](./references/github_com_bschiffthaler_seidr.md)
- [Bioconda Seidr Overview](./references/anaconda_org_channels_bioconda_packages_seidr_overview.md)
- [Seidr Commit History](./references/github_com_bschiffthaler_seidr_commits_master.md)