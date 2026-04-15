---
name: backspinpy
description: BackSPIN is a biclustering algorithm that simultaneously clusters genes and cells in single-cell RNA-sequencing data by iteratively reordering and splitting the expression matrix. Use when user asks to cluster scRNA-seq data, identify cell populations and gene modules, or perform hierarchical biclustering on a CEF formatted file.
homepage: https://github.com/linnarsson-lab/BackSPIN
metadata:
  docker_image: "quay.io/biocontainers/backspinpy:0.2.1--pyh24bf2e0_1"
---

# backspinpy

## Overview

BackSPIN (Back-Sorted Points Into Neighborhoods) is a biclustering algorithm designed to simultaneously cluster genes and cells. It is particularly effective for single-cell RNA-sequencing (scRNA-seq) analysis, where it identifies distinct cell populations and the specific gene modules that define them. The tool operates by iteratively reordering the expression matrix and performing binary splits until a stopping criterion is met or a maximum depth is reached. This skill provides guidance on executing the CLI, optimizing performance through feature selection, and configuring the splitting logic.

## Command Line Usage

The primary command for the tool is `backspin`. It requires input in the Column Enriched Format (CEF).

### Basic Execution
To run a standard clustering workflow, you must provide the input file, output destination, and the maximum depth of the hierarchy.

```bash
backspin -i input.cef -o output_clustered.cef -d 4
```

### Mandatory Arguments
- `-i`, `--input`: Path to the CEF formatted tab-delimited file. Rows should be genes; columns should be cells/samples.
- `-o`, `--output`: The filename for the resulting annotated CEF file.
- `-d`: The number of nested levels (binary splits) to attempt. A depth of 4 allows for a maximum of 16 clusters ($2^4$).

### Performance Optimization (Feature Selection)
BackSPIN has a computational complexity of $O(n^3)$. To prevent excessive runtimes on large datasets, always use the feature selection flag to limit the number of genes processed.

- `-f [int]`: Selects the top $N$ most variable genes based on an expected noise curve (CV-vs-mean).
- **Expert Tip**: For most exploratory runs, `-f 500` provides a good balance between biological resolution and processing speed.

### Fine-Tuning the Splitting Logic
You can control how and when the algorithm decides to split a group of cells:
- `-g [int]`: Minimum number of genes a group must contain to allow a split (default: 2).
- `-c [int]`: Minimum number of cells a group must contain to allow a split (default: 2).
- `-k [float]`: The minimum score a breaking point must reach to be suitable for splitting (default: 1.15). Increase this value for more conservative/fewer clusters.
- `-r [float]`: Correlation threshold for assigning genes to groups when average expression differences are low (default: 0.2).

### Verbose Output
Use the `-v` flag to monitor the progress of the iterations and splits in real-time.

## Interpreting the Output

The output is a reorganized CEF file containing:
1. **Filtered Genes**: Only the genes selected by the `-f` parameter are retained.
2. **Sorted Matrix**: Rows and columns are reordered according to the SPIN algorithm to place similar elements near each other.
3. **Cluster Attributes**: New row and column attributes are added (e.g., `Level_1_group`, `Level_2_group`) indicating the cluster assignment at each hierarchical level.

## Python API Integration

For advanced workflows or interactive analysis in Jupyter/IPython, you can import the core functions directly:

```python
from backspinpy import SPIN, backSPIN, feature_selection, CEF_obj

# Load CEF data
cef = CEF_obj()
cef.read('data.cef')

# Perform feature selection
# (Logic for selecting variable genes before clustering)
```

## Reference documentation
- [BackSPIN GitHub Repository](./references/github_com_linnarsson-lab_BackSPIN.md)
- [Bioconda backspinpy Overview](./references/anaconda_org_channels_bioconda_packages_backspinpy_overview.md)