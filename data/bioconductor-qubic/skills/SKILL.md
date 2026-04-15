---
name: bioconductor-qubic
description: bioconductor-qubic performs qualitative biclustering to identify co-expressed gene modules in large-scale gene expression datasets. Use when user asks to identify biclusters, discretize expression data, visualize results with heatmaps, or construct co-expression networks.
homepage: https://bioconductor.org/packages/release/bioc/html/QUBIC.html
---

# bioconductor-qubic

name: bioconductor-qubic
description: Qualitative Biclustering (QUBIC) for gene expression data analysis. Use this skill to identify co-expressed gene modules (biclusters) in large-scale microarray or RNA-seq datasets, perform discretization, visualize results with heatmaps, and construct co-expression networks.

## Overview

QUBIC is a highly efficient biclustering algorithm designed for qualitative analysis of gene expression data. It is particularly effective for large-scale biological datasets. The package provides tools for data discretization, bicluster identification (including query-based and expansion methods), and downstream visualization through heatmaps and network graphs.

## Core Workflow

### 1. Data Preparation and Discretization
QUBIC operates on discretized data. While the main biclustering function can handle real-valued matrices by discretizing them internally, you can perform this step manually to inspect the qualitative representation.

```R
library(QUBIC)
# Load your gene expression matrix (genes as rows, conditions as columns)
# Example discretization
discrete_matrix <- qudiscretize(expression_matrix)
```

### 2. Identifying Biclusters
The primary interface is the `biclust()` function from the `biclust` package, using the `BCQU()` method.

```R
# Basic biclustering
res <- biclust::biclust(expression_matrix, method = BCQU())

# Advanced parameters
# r: range of ranks (default 1)
# q: percentage of symbols to be used in discretization (default 0.06)
# c: consistency level (default 0.95)
# k: number of biclusters to find
res <- biclust::biclust(expression_matrix, method = BCQU(), r = 1, q = 0.06, c = 0.95)

# Summary of results
summary(res)
```

### 3. Specialized Biclustering Modes
*   **Query-based Biclustering:** Use prior biological knowledge (e.g., protein-protein interaction weights) to guide the process.
    ```R
    res_query <- biclust(expression_matrix, method = BCQU(), weight = weight_matrix)
    ```
*   **Bicluster Expansion:** Expand existing biclusters to include more genes based on a consistency level.
    ```R
    res_expanded <- biclust(expression_matrix, method = BCQU(), seedbicluster = res, f = 0.25)
    ```

### 4. Visualization and Export
*   **Heatmaps:** Visualize one or more biclusters.
    ```R
    # Heatmap for the first bicluster
    quheatmap(expression_matrix, res, number = 1)
    
    # Overlapped heatmap for biclusters 1 and 2
    quheatmap(expression_matrix, res, number = c(1, 2))
    ```
*   **Network Analysis:** Create co-expression networks from biclusters.
    ```R
    # Construct network for bicluster 2
    net <- qunetwork(expression_matrix, res, number = 2, group = 2, method = "spearman")
    
    # Plot using qgraph
    if (requireNamespace("qgraph")) {
      qgraph::qgraph(net[[1]], groups = net[[2]], layout = "spring")
    }
    
    # Export to XGMML for Cytoscape
    sink("network.gr")
    qunet2xml(net)
    sink()
    ```

## Tips for Success
*   **Large Datasets:** QUBIC is optimized in C++ and is very efficient for datasets with tens of thousands of genes.
*   **Parameter Tuning:** If too few biclusters are found, consider lowering the consistency level `c` or adjusting the discretization quantile `q`.
*   **Comparison:** Use `showinfo(matrix, c(res1, res2))` to compare results obtained with different parameters or algorithms.

## Reference documentation
- [QUBIC Tutorial](./references/qubic_vignette.md)