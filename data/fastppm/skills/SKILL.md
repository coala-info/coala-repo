---
name: fastppm
description: fastppm estimates tumor clone frequencies by optimizing convex loss functions over a fixed phylogenetic tree. Use when user asks to regress subclonal frequencies, perform subclonal deconvolution, or fit variant read counts to a known evolutionary structure.
homepage: https://github.com/elkebir-group/fastppm
metadata:
  docker_image: "quay.io/biocontainers/fastppm:1.1.1--py39h2de1943_0"
---

# fastppm

## Overview
The `fastppm` (Fast Perfect Phylogeny Mixture) tool is a high-performance C++/Python library designed for the regression of tumor clone frequencies. It estimates the unknown frequency matrix $F$ by optimizing convex loss functions over a fixed phylogenetic tree. This is particularly useful in subclonal deconvolution tasks where the evolutionary relationship between clones is known, and you need to determine their prevalence across multiple samples using variant and total read count data.

## Installation
The tool is primarily distributed via Bioconda for Linux and macOS.
```bash
conda install -c bioconda fastppm
```

## Command Line Interface (CLI)
The CLI tool `fastppm-cli` requires three specific input files:
1.  **Tree File**: An adjacency list representing the $n$-clonal tree.
2.  **Variant Matrix**: An $m \times n$ matrix of variant read counts.
3.  **Total Matrix**: An $m \times n$ matrix of total read counts.

### Basic Usage
```bash
fastppm-cli --variant variant_counts.txt \
            --total total_counts.txt \
            --tree tree_adj_list.txt \
            --output results.json \
            --format verbose
```

### Key Arguments and Best Practices
- **Output Format**: By default, the tool only outputs the loss objective and runtime. Always use `--format verbose` if you need the estimated frequency matrix ($F$) and usage matrix ($U$).
- **Loss Functions (`--loss`)**:
    - `l2`: Default. Best for general least-squares estimation.
    - `binomial`: Recommended for standard sequencing read count data.
    - `beta_binomial`: Use when data exhibits overdispersion. Requires the `--precision` parameter (default: 10).
- **Node Labeling**: Ensure nodes in your tree file are labeled $\{0, \ldots, n-1\}$. These labels must correspond exactly to the columns in your variant and total read count matrices.

## Python API Usage
The Python library provides a more flexible way to integrate regression into bioinformatics pipelines.

### Regressing from Read Counts
```python
import fastppm

# Tree as an adjacency list
tree = [[1, 2], [3, 4], [], [], []]
# Variant and Total counts as lists of lists (m samples x n clones)
var = [[9, 4, 4, 1, 2]]
tot = [[10, 10, 10, 10, 10]]

results = fastppm.regress_counts(tree, var, tot, loss_function="binomial")
print(results['frequency_matrix'])
```

### Regressing from Frequencies
If you already have frequency estimates and want to fit them to the tree structure:
```python
freqs = [[0.9, 0.4, 0.4, 0.1, 0.2]]
results = fastppm.regress_frequencies(tree, freqs, loss_function="l2")
```

## Expert Tips
- **Tree Structure**: The tool assumes a fixed tree. If the tree structure is uncertain, you may need to run `fastppm` across multiple candidate trees and compare the `objective` values returned in the JSON output.
- **Memory Efficiency**: For very large matrices, the C++ CLI is generally more memory-efficient than the Python wrapper.
- **Piecewise Linear Approximation (PLA)**: For complex loss functions, you can use `*_pla` or `*_ppla` variants with the `--segments` (or `-K`) flag to control the approximation accuracy.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_elkebir-group_fastppm.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_fastppm_overview.md)