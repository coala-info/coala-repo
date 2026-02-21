---
name: chronumental
description: Chronumental is a high-performance tool designed to transform phylogenetic divergence trees—where branch lengths represent genetic substitutions—into time-trees where branch lengths represent chronological time.
homepage: https://github.com/theosanderson/chronumental
---

# chronumental

## Overview

Chronumental is a high-performance tool designed to transform phylogenetic divergence trees—where branch lengths represent genetic substitutions—into time-trees where branch lengths represent chronological time. While most molecular clock tools struggle with large datasets, Chronumental utilizes JAX to represent the optimization problem as a differentiable graph, enabling it to scale to phylogenies containing millions of nodes using CPU or GPU acceleration.

## Installation

The recommended way to install Chronumental in an isolated environment is via pipx:

```bash
pipx install chronumental
```

Alternatively, use Bioconda:

```bash
conda install -c bioconda chronumental
```

## Common CLI Patterns

### Basic Time-Tree Estimation
To run a standard calibration, provide the divergence tree and a metadata file containing sample dates:

```bash
chronumental --tree input_tree.nwk --dates metadata.tsv --steps 100
```

### Handling Large Compressed Files
Chronumental natively supports gzipped inputs, which is essential for monumental trees:

```bash
chronumental --tree public-2024-01-01.all.nwk.gz --dates metadata.tsv.gz --steps 200
```

### Manual Reference Calibration
By default, the tool uses the earliest date in your metadata as the temporal anchor. If your earliest sample has unreliable metadata, manually specify a reference node:

```bash
chronumental --tree tree.nwk --dates dates.tsv --reference_node "Node_Name_01"
```

## Expert Tips and Best Practices

- **Scaling Threshold**: If your tree has fewer than 10,000 nodes, consider using TreeTime for more advanced statistical features. Use Chronumental specifically when dealing with "monumental" trees where other tools crash or hang.
- **Convergence**: The `--steps` parameter controls the number of optimization iterations. If the resulting time-tree looks inconsistent or branch lengths are unexpected, increase the steps (e.g., to 500 or 1000) and monitor for a lower loss value.
- **Metadata Formatting**: Ensure your dates file is a TSV. The tool typically expects a column named "strain" or "name" to match tree leaves and a date column.
- **Hardware Acceleration**: Since Chronumental uses JAX, it will automatically attempt to use a GPU if available and configured in your environment, significantly speeding up the optimization of million-node trees.
- **Visualisation**: For exploring the output, Chronumental integrates well with Taxonium, which allows for seamless switching between distance and time views in large phylogenies.

## Reference documentation

- [Chronumental GitHub Repository](./references/github_com_theosanderson_chronumental.md)
- [Bioconda Chronumental Overview](./references/anaconda_org_channels_bioconda_packages_chronumental_overview.md)