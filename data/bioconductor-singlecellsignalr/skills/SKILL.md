---
name: bioconductor-singlecellsignalr
description: SingleCellSignalR is an R package designed to infer and visualize cell-cell communication from single-cell gene expression data by mapping ligand-receptor interactions. Use when user asks to infer paracrine or autocrine signaling, identify potential cell-cell interactions using LR-scores, or link ligand-receptor pairs to biological pathways.
homepage: https://bioconductor.org/packages/release/bioc/html/SingleCellSignalR.html
---


# bioconductor-singlecellsignalr

## Overview

`SingleCellSignalR` is an R package designed to infer cell-cell communication from single-cell data. It maps expressed genes to a curated ligand-receptor database (LR*db*) to identify potential interactions. The package supports two primary methodologies:
1. **LR-score (Network-free)**: A purely expression-based scoring system (legacy Version 1).
2. **Differential Mode (Network-based)**: A statistical model linking L-R interactions with biological pathways (Version 2, leveraging `BulkSignalR`).

## Data Preparation

The input must be a gene expression matrix and a vector of cell population assignments.

```r
library(SingleCellSignalR)

# 1. Prepare the expression matrix (Genes in rows, Cells in columns)
# Data should be log-transformed
mat <- log1p(data.matrix(example_dataset[,-1])) / log(2)
rownames(mat) <- example_dataset[[1]]

# 2. Define cell populations/clusters
# Example: simple clustering or pre-defined labels
d <- dist(t(mat[rowMeans(mat) > 0.05, ]))
clusters <- paste0("pop_", cutree(hclust(d, method="ward.D"), 5))
```

## Workflows

### 1. LR-score Approach (SCSRNoNet)
Use this for a quick, expression-based inference without requiring complex pathway modeling.

```r
# Initialize the object
scsrnn <- SCSRNoNet(mat, 
                    populations = clusters, 
                    log.transformed = TRUE, 
                    normalize = FALSE)

# Perform inferences
scsrnn <- performInferences(scsrnn, 
                            min.LR.score = 0.5, 
                            verbose = TRUE)
```

### 2. Differential/Network Approach (SCSRNet)
Use this for more robust inferences that consider biological processes and pathways.

```r
# Initialize the object
scsrcn <- SCSRNet(mat, 
                  populations = clusters, 
                  log.transformed = TRUE, 
                  normalize = FALSE)

# Perform inferences (can be restricted to specific populations)
scsrcn <- performInferences(scsrcn, 
                            selected.populations = c("pop_1", "pop_2"),
                            min.logFC = log2(1.01), 
                            max.pval = 0.05)
```

## Results and Visualization

### Extracting Interactions
Once inferences are performed, you can extract specific signaling directions.

```r
# Get autocrine interactions (self-signaling)
auto <- getAutocrines(scsrcn, "pop_1")

# Get paracrine interactions (signaling from pop_1 to pop_2)
para <- getParacrines(scsrcn, "pop_1", "pop_2")
```

### Visualization
The package provides a bubble plot to visualize the strength and significance of interactions across cell types.

```r
cellNetBubblePlot(scsrcn)
```

## Tips for Success
- **Normalization**: Ensure your data is properly normalized and log-transformed before input. If the data is already transformed, set `log.transformed = TRUE` and `method = "log-only"` in the constructor.
- **Filtering**: Use `min.count` and `prop` parameters in `SCSRNet`/`SCSRNoNet` to filter out lowly expressed genes that might introduce noise.
- **BulkSignalR**: For deeper pathway analysis, refer to the `BulkSignalR` package, which provides the underlying database and statistical framework for `SingleCellSignalR` v2.

## Reference documentation
- [SingleCellSignalR-Main](./references/SingleCellSignalR-Main.md)