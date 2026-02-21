---
name: bioconductor-apl
description: The package performs correspondence analysis (CA) and allows to identify cluster-specific genes using Association Plots. Additionally, APL computes the cluster-specificity scores for all genes which allows to rank the genes by their specificity for a selected cell cluster of interest.
homepage: https://bioconductor.org/packages/release/bioc/html/APL.html
---

# bioconductor-apl

name: bioconductor-apl
description: Perform correspondence analysis (CA) and identify cluster-specific genes using Association Plots (APL). Use this skill when analyzing single-cell transcriptomics data to rank genes by cluster-specificity, visualize cell-gene relationships in a shared embedding, or perform GO enrichment on cluster-specific markers.

# bioconductor-apl

## Overview

The `APL` package implements Association Plots based on Correspondence Analysis (CA). Unlike PCA, CA allows for the simultaneous embedding of both cells and genes in the same dimensionality-reduced space. This skill enables the identification of genes characteristic of specific cell clusters by calculating cluster-specificity scores ($S_\alpha$) and visualizing them to highlight top markers.

## Core Workflow

### 1. Data Preparation
APL works with log-normalized counts. It supports `SingleCellExperiment`, `Seurat`, or raw matrices.

```r
library(APL)
# Assuming 'sce' is a SingleCellExperiment object with logcounts
# and 'cell.type' column in colData
```

### 2. Quick Start with runAPL
The `runAPL()` function wraps CA computation, dimension reduction, and plotting into one step.

```r
# Generate Association Plot for a specific cluster (e.g., "oligodendrocytes")
runAPL(sce, 
       assay = "logcounts", 
       top = 5000, 
       group = which(sce$cell.type == "oligodendrocytes"), 
       type = "ggplot")
```

### 3. Step-by-Step Analysis

#### Correspondence Analysis (CA)
Compute the CA embedding. Use `top` to select the most variable genes.

```r
ca <- cacomp(sce, assay = "logcounts", top = 5000)
# Result is a 'cacomp' object
```

#### Dimension Reduction
Identify the optimal number of dimensions to retain (e.g., using the elbow rule) to filter noise.

```r
# Calculate dimensions using elbow rule
pd <- pick_dims(ca, mat = logcounts(sce), method = "elbow_rule", reps = 10)
ca <- subset_dims(ca, dims = pd)
```

#### Association Plot Coordinates and Scoring
Calculate coordinates for a specific cluster and compute the $S_\alpha$ specificity score.

```r
# Define cluster indices
cluster_idx <- which(sce$cell.type == "endothelial")

# Calculate APL coordinates
ca <- apl_coords(ca, group = cluster_idx)

# Calculate specificity scores (requires original matrix)
ca <- apl_score(ca, mat = logcounts(sce))

# Access scores
scores <- cacomp_slot(ca, "APL_score")
```

### 4. Visualization

*   **Association Plot**: High x-axis values indicate association; low y-axis values indicate specificity.
*   **Biplot**: Standard CA visualization of cells and genes.

```r
# Plot APL with specific genes highlighted
apl(ca, show_score = TRUE, row_labs = TRUE, rows_idx = c("GENE1", "GENE2"))

# Standard CA Biplot
ca_biplot(ca, col_labels = cluster_idx)
```

### 5. GO Enrichment
Perform Gene Ontology enrichment directly on the cluster-specific genes identified by APL.

```r
enr <- apl_topGO(ca, ontology = "BP", organism = "hs", score_cutoff = 1)
plot_enrichment(enr)
```

## Tips and Best Practices
*   **Input Requirements**: Input matrices must have both row and column names.
*   **Feature Selection**: By default, `cacomp` uses the top 5,000 variable genes. Increase this if you are looking for markers of very small, rare clusters.
*   **Interactive Exploration**: Set `type = "plotly"` in `apl()` or `ca_biplot()` to enable hover-over gene names and interactive zooming.
*   **Object Conversion**: Use `as.cacomp(sce)` to extract CA results if they were stored back into a `SingleCellExperiment` or `Seurat` object via `return_input = TRUE`.

## Reference documentation
- [Analyzing data with APL](./references/APL.md)