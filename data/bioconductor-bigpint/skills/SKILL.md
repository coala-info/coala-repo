---
name: bioconductor-bigpint
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.9/bioc/html/bigPint.html
---

# bioconductor-bigpint

## Overview
The `bigPint` package provides specialized visualization methods for differential expression analysis. It helps researchers transition from "big data" to "pint-sized" manageable visualizations. It is particularly effective for identifying normalization artifacts, mislabeled samples, and verifying the quality of differentially expressed gene (DEG) designations through multi-dimensional plots.

## Core Data Structures
The package relies on two primary input formats:

1.  **Data Object (`data`)**: A data frame where the first column is "ID" (character). Subsequent columns must follow the `Treatment.Replicate` format (e.g., `A.1`, `A.2`, `B.1`).
2.  **Data Metrics Object (`dataMetrics`)**: A list of data frames, one for each pairwise comparison (e.g., `N_P`). Each data frame must contain an "ID" column and quantitative metrics like `PValue`, `FDR`, and `logFC`.
3.  **SummarizedExperiment**: Most functions also support `SummarizedExperiment` objects via the `dataSE` parameter.

## Typical Workflow

### 1. Data Preprocessing and Quality Control
Before DEG analysis, check for normalization issues and sample swaps.
```r
library(bigPint)
data("soybean_ir_sub")

# Log transformation is often recommended
soybean_ir_sub[,-1] <- log(soybean_ir_sub[,-1] + 1)

# Check distributions across samples
ret_pcp <- plotPCP(data = soybean_ir_sub, saveFile = FALSE)
grid::grid.draw(ret_pcp[["N_P"]])

# Check for sample swaps or geometric streaks
ret_sm <- plotSM(data = soybean_ir_sub, saveFile = FALSE)
ret_sm[["N_P"]]
```

### 2. Visualizing Differentially Expressed Genes (DEGs)
Superimpose DEGs onto background data to verify they deviate from the x=y line in treatment comparisons but stay on it for replicates.
```r
# Assuming dataMetrics is created via edgeR or DESeq2
ret_volcano <- plotVolcano(data = soybean_ir_sub, dataMetrics = soybean_ir_sub_metrics, 
                           threshVal = 0.05, saveFile = FALSE)
ret_volcano[["N_P"]]
```

### 3. Hierarchical Clustering
Group DEGs into clusters with similar expression patterns to simplify interpretation.
```r
# Standardize data first for better clustering
data_st <- as.data.frame(t(apply(as.matrix(soybean_ir_sub[,-1]), 1, scale)))
data_st$ID <- as.character(soybean_ir_sub$ID)
# ... (reorder columns to put ID first)

# Cluster into 4 groups and plot
ret_clust <- plotClusters(data = data_st, dataMetrics = soybean_ir_sub_metrics, 
                          nC = 4, clusterAllData = FALSE, verbose = TRUE)
grid::grid.draw(ret_clust[["N_P_4"]])
```

### 4. Interactive Exploration
Use Shiny-based apps for dynamic filtering and gene hovering.
```r
# Launch interactive volcano plot
app <- plotVolcanoApp(data = soybean_ir_sub, dataMetrics = soybean_ir_sub_metrics)
if (interactive()) {
    shiny::runApp(app)
}
```

## Key Functions
- `plotSM()` / `plotSMApp()`: Scatterplot matrices (static/interactive).
- `plotPCP()` / `plotPCPApp()`: Parallel Coordinate Plots.
- `plotLitre()` / `plotLitreApp()`: Litre plots for individual gene focus.
- `plotVolcano()` / `plotVolcanoApp()`: Volcano plots with background density.
- `plotClusters()`: Hierarchical clustering and visualization.

## Tips for Success
- **Standardization**: When using `plotClusters` or `plotPCP`, standardizing genes (mean=0, sd=1) helps visualize relative changes across treatments regardless of absolute magnitude.
- **Column Naming**: Ensure sample columns use a dot separator (e.g., `S1.1`) and metrics list elements use an underscore (e.g., `S1_S2`).
- **Large Datasets**: For datasets with many samples, use `geneList` to subset the visualization to specific genes of interest to avoid overplotting.

## Reference documentation
- [Hierarchical clustering](./references/clusters.Rmd)
- [Data object](./references/data.Rmd)
- [Data metrics object](./references/dataMetrics.Rmd)
- [Installation](./references/installation.Rmd)
- [Producing interactive plots](./references/interactive.Rmd)
- [Manuscripts](./references/manuscripts.Rmd)
- [Recommended RNA-seq pipeline](./references/pipeline.Rmd)
- [Introduction to bigPint plots](./references/plotIntro.Rmd)
- [Producing static plots](./references/static.Rmd)
- [SummarizedExperiment version](./references/summarizedExperiment.Rmd)