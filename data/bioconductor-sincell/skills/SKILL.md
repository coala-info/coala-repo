---
name: bioconductor-sincell
description: This tool provides a methodological toolbox for analyzing single-cell RNA-seq data to uncover hierarchical cell-state transitions. Use when user asks to calculate cell-to-cell distances, perform dimensionality reduction, construct cell-state hierarchies using algorithms like MST or IMC, and statistically validate the robustness of cell-state transitions.
homepage: https://bioconductor.org/packages/release/bioc/html/sincell.html
---


# bioconductor-sincell

## Overview

The `sincell` package provides a methodological toolbox for analyzing single-cell RNA-seq data to uncover hierarchical cell-state transitions (e.g., differentiation or activation processes). It follows a modular workflow:
1.  **Similarity Assessment**: Calculating cell-to-cell distances, optionally after dimensionality reduction.
2.  **Graph Building**: Constructing hierarchies using algorithms like Minimum Spanning Tree (MST) or Iterative Mutual Clustering (IMC).
3.  **Statistical Validation**: Testing the robustness of the resulting hierarchy against stochastic noise and sampling bias.
4.  **Functional Interpretation**: Associating hierarchies with known gene sets or pathways.

## Core Workflow

### 1. Initialization
The workflow starts with a normalized, variance-stabilized expression matrix (rows = genes, columns = cells).

```R
library(sincell)
# SO is a Sincell Object
SO <- sc_InitializingSincellObject(ExpressionMatrix)
```

### 2. Dimensionality Reduction and Distance
You can calculate distances directly on the expression matrix or in a reduced dimensional space.

```R
# Direct distance (e.g., euclidean, pearson, spearman, cosine, MI, L1)
SO <- sc_distanceObj(SO, method="euclidean")

# Via Dimensionality Reduction (e.g., PCA, ICA, tSNE, classical-MDS, nonmetric-MDS)
SO <- sc_DimensionalityReductionObj(SO, method="ICA", dim=2)
```

### 3. Clustering (Optional)
Clustering can be used to group highly similar cells before graph building to avoid noise-driven connections.

```R
# K-Nearest Neighbors (KNN)
SO <- sc_clusterObj(SO, clust.method="knn", k=3)
```

### 4. Building the Hierarchy
Construct the cell-state graph using one of three primary algorithms.

```R
# Minimum Spanning Tree (MST)
SO <- sc_GraphBuilderObj(SO, graph.algorithm="MST", graph.using.cells.clustering=FALSE)

# Maximum Similarity Spanning Tree (SST)
SO <- sc_GraphBuilderObj(SO, graph.algorithm="SST")

# Iterative Mutual Clustering (IMC)
SO <- sc_GraphBuilderObj(SO, graph.algorithm="IMC")
```

### 5. Statistical Support
To determine if a hierarchy is robust or driven by noise, use resampling techniques.

**Gene Resampling:**
```R
SO <- sc_StatisticalSupportByGeneSubsampling(SO, num_it=100)
# Access results
summary(SO[["StatisticalSupportbyGeneSubsampling"]])
```

**In silico Cell Replicates:**
Generates replicates based on mean-variance relationships to test stability against technical/biological noise.
```R
SO <- sc_InSilicoCellsReplicatesObj(SO, method="variance.deciles", multiplier=100)
SO <- sc_StatisticalSupportByReplacementWithInSilicoCellsReplicates(SO, num_it=100, fraction.cells.to.replace=1)
```

### 6. Visualization and Interpretation
Visualizing the graph and coloring by metadata (e.g., time points) or marker genes.

```R
# Color cells by a marker gene
colorMarker <- sc_marker2color(SO, marker="CDK1", color.minimum="yellow", color.maximum="blue")

# Plotting the igraph object
plot.igraph(SO[["cellstateHierarchy"]], vertex.color=colorMarker, layout=layout.kamada.kawai)
```

## Functional Association
Test if the hierarchy is driven by a specific functional gene set (e.g., a Reactome pathway).

```R
SO <- sc_AssociationOfCellsHierarchyWithAGeneSet(SO, GeneSetVector, minimum.geneset.size=30, p.value.assessment=TRUE)
```

## Reference documentation

- [Sincell: R package for statistical assessment of cell state hierarchies from single-cell RNA-seq](./references/sincell-vignette.md)