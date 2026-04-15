---
name: bioconductor-gnet2
description: GNET2 constructs gene regulatory networks by clustering genes into functional modules using an iterative Expectation-Maximization process. Use when user asks to build gene regulatory networks, identify transcription factor targets, or visualize regulatory tree logic from transcriptomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/GNET2.html
---

# bioconductor-gnet2

## Overview
GNET2 is a Bioconductor package designed to construct gene regulatory networks by clustering genes into functional modules using an Expectation-Maximization (E-M) process. It iteratively assigns Transcription Factors (TFs) to modules and genes to those TFs until convergence. This approach is particularly useful for identifying which regulators drive specific biological processes based on transcriptomic data (e.g., RNA-Seq log2 RPKM).

## Installation
Install the package via Bioconductor or GitHub:
```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("GNET2")

# Alternatively, from GitHub:
# devtools::install_github("chrischen1/GNET2")
library(GNET2)
```

## Core Workflow

### 1. Data Preparation
GNET2 requires an expression matrix and a character vector of potential regulators.
- **Expression Data**: A $p \times n$ matrix (genes as rows, samples as columns).
- **Regulator Names**: A list of gene IDs known to be regulators (e.g., TFs from PlantTFDB).

```R
# Example: exp_data is a matrix, reg_names is a vector of TF IDs
# Ensure rownames(exp_data) contains the reg_names
gnet_result <- gnet(exp_data, reg_names, init_method='boosting', init_group_num=8, heuristic=TRUE)
```

### 2. Visualizing Modules and Trees
GNET2 provides specialized plotting functions to interpret the regulatory logic.
- **Module Heatmap**: Shows how samples are split by the regression tree and how downstream genes are regulated.
- **Regulatory Tree**: Visualizes the decision logic of the regulators for a specific module.

```R
# Plot heatmap for module 1
plot_gene_group(gnet_result, group_idx = 1, plot_leaf_labels = TRUE)

# Plot tree structure for module 1
plot_tree(gnet_result, group_idx = 1)
```

### 3. Evaluating Module Significance
You can compare GNET2 clusters with experimental conditions (categorical or ordinal) using similarity scores.
- **Categorical**: Uses Adjusted Rand Index.
- **Ordinal**: Uses inverse K-L Divergence.

```R
# exp_labels is a vector of condition labels
exp_labels_factor = as.numeric(factor(exp_labels))
similarity_score(gnet_result, exp_labels_factor)
```

### 4. Extracting Results
Access the specific genes and interactions within the generated object.

```R
# Get total module count
gnet_result$modules_count

# Get regulators and targets for a specific module
gnet_result$regulators[[1]]
gnet_result$target_genes[[1]]

# Extract all interactions as an adjacency matrix
edge_matrix <- extract_edges(gnet_result)
```

## Tips and Best Practices
- **Knee Point Detection**: Use `plot_group_correlation(gnet_result)` to identify modules with high internal correlation. Groups above the "knee point" are generally more robust for downstream analysis.
- **Initialization**: The `init_method` can be 'boosting' or 'random'. Boosting is generally preferred for biological data.
- **Heuristic Mode**: Setting `heuristic = TRUE` in the `gnet` function speeds up the process for large datasets.

## Reference documentation
- [Build functional gene modules with GNET2](./references/run_gnet2.md)
- [GNET2 Vignette Source](./references/run_gnet2.Rmd)