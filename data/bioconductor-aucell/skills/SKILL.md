---
name: bioconductor-aucell
description: AUCell identifies cells with active gene signatures in single-cell RNA-seq data using a ranking-based Area Under the Curve method. Use when user asks to score gene sets, identify active gene modules, or determine cell-type assignments based on expression rankings.
homepage: https://bioconductor.org/packages/release/bioc/html/AUCell.html
---

# bioconductor-aucell

name: bioconductor-aucell
description: Identify cells with active gene sets (signatures) in single-cell RNA-seq data using the Area Under the Curve (AUC) method. Use this skill when you need to score gene signatures, determine cell-type assignments based on expression rankings, or explore the activity of specific gene modules across a single-cell dataset.

# bioconductor-aucell

## Overview

AUCell is a Bioconductor package designed to identify cells with active gene signatures in single-cell RNA-seq (scRNA-seq) data. It uses a ranking-based approach (Area Under the Curve) that is independent of gene expression units and normalization methods. This makes it highly robust against technical noise and library-size variations.

The workflow typically involves three main steps:
1. **Building rankings**: Ranking genes in each cell based on expression.
2. **Calculating AUC**: Scoring the enrichment of gene sets within the top-ranked genes.
3. **Setting thresholds**: Determining which cells are "active" for a given signature.

## Core Workflow

### 1. Setup and Data Input
AUCell requires an expression matrix (genes as rows, cells as columns) and gene sets (as a list or `GSEABase::GeneSetCollection`).

```r
library(AUCell)
library(GSEABase)

# Load expression matrix (sparse matrix recommended)
# exprMatrix <- as(my_counts, "dgCMatrix")

# Define gene sets
geneSets <- list(mySignature = c("GENE1", "GENE2", "GENE3"))
```

### 2. Running the Full Pipeline
The wrapper function `AUCell_run` performs both ranking and AUC calculation.

```r
# aucMaxRank defines the top % of genes to consider (default 5%)
cells_AUC <- AUCell_run(exprMatrix, geneSets, aucMaxRank=nrow(exprMatrix)*0.05)
```

### 3. Step-by-Step Execution
For more control or to save intermediate rankings:

```r
# Step 1: Build rankings
cells_rankings <- AUCell_buildRankings(exprMatrix, plotStats=TRUE)

# Step 2: Calculate AUC
cells_AUC <- AUCell_calcAUC(geneSets, cells_rankings)
```

### 4. Determining Active Cells (Thresholding)
AUCell provides tools to identify the population of cells where a signature is active.

```r
# Explore thresholds and assign cells
# This generates histograms with suggested thresholds
cells_assignment <- AUCell_exploreThresholds(cells_AUC, plotHist=TRUE, assign=TRUE)

# Extract assigned cells for a specific gene set
active_cells <- cells_assignment$mySignature$assignment

# Manually view/set a threshold
AUCell_plotHist(cells_AUC["mySignature",], aucThr=0.2)
```

## Visualization and Exploration

### Plotting on t-SNE/UMAP
You can visualize AUC scores on reduced dimensionality plots to see cluster-specific activity.

```r
# Simple AUC plot on existing t-SNE coordinates
AUCell_plotTSNE(tSNE=myTsneCoords, exprMat=exprMatrix, 
                cellsAUC=cells_AUC, thresholds=selectedThresholds)
```

### Heatmaps
Create an incidence matrix of cell assignments to visualize which signatures are active across the population.

```r
# Convert assignments to a table
cellsAssigned <- lapply(cells_assignment, function(x) x$assignment)
assignmentTable <- reshape2::melt(cellsAssigned)

# Create incidence matrix
assignmentMat <- table(assignmentTable$L1, assignmentTable$value)
```

## Tips for Success

- **aucMaxRank**: By default, AUCell only looks at the top 5% of expressed genes. If your dataset has very high sensitivity (many genes detected per cell), you may need to increase this value.
- **Gene Set Size**: Signatures between 100 and 2000 genes are generally the most stable. Very small gene sets (<10 genes) are prone to noise.
- **Normalization**: AUCell is ranking-based and can be run on raw counts, TPM, or UMI counts. It is generally independent of the normalization procedure.
- **Parallelization**: For large datasets, use the `BPPARAM` argument in `AUCell_run` or `AUCell_calcAUC` (e.g., `BPPARAM=BiocParallel::MulticoreParam(4)`).

## Reference documentation

- [AUCell: Identifying cells with active gene sets](./references/AUCell.md)