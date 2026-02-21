---
name: r-beyondcell
description: R package beyondcell (documentation from project home).
homepage: https://cran.r-project.org/web/packages/beyondcell/index.html
---

# r-beyondcell

## Overview
`beyondcell` is an R package designed to analyze scRNA-seq data to identify functional heterogeneity in drug response. It transforms gene expression matrices into drug sensitivity scores (Beyondcell scores) by leveraging drug-related gene sets (e.g., from SANGER or CTRP). This allows researchers to identify "Therapeutic Clusters" (TCs) and propose targeted treatments based on single-cell profiles.

## Installation
To install the package from CRAN:
```R
install.packages("beyondcell")
```

## Core Workflow

### 1. Object Initialization
Beyondcell works with a `beyondcell` object, which can be created from a Seurat object or a normalized expression matrix.
```R
library(beyondcell)

# Create beyondcell object from a Seurat object
bc <- GenerateBCobj(SeuratObj = my_seurat_object)
```

### 2. Scoring Drug Sensitivity
The core function `beyondcellScore` calculates the enrichment of drug-response signatures.
```R
# Calculate scores using a specific database (e.g., SANGER or CTRP)
bc <- beyondcellScore(bc, expr = my_seurat_object@assays$RNA@data, database = "SANGER")
```

### 3. Identifying Therapeutic Clusters (TCs)
Group cells based on their drug response profiles rather than their transcriptomic state.
```R
# Cluster cells based on drug scores
bc <- FindTCs(bc, resolution = 0.5)

# Run UMAP on drug scores
bc <- RunBCUMAP(bc)
```

### 4. Visualization
Beyondcell provides specialized plotting functions to visualize drug sensitivities and clusters.
```R
# Plot UMAP of Therapeutic Clusters
bc_UMAP(bc, group.by = "TC")

# Plot specific drug sensitivity across cells
bc_FeaturePlot(bc, features = "Gefitinib")

# Compare Seurat clusters with Therapeutic Clusters
bc_Heatmap(bc, group.by = "seurat_clusters")
```

### 5. Differential Response Analysis
Identify drugs that are significantly more effective in one cluster compared to others.
```R
# Find differentially sensitive drugs
diff_drugs <- GetDiffGenes(bc, group.by = "TC")
```

## Key Functions
- `GenerateBCobj()`: Initializes the beyondcell container.
- `beyondcellScore()`: Computes drug enrichment scores.
- `FindTCs()`: Performs clustering on the drug response space.
- `bc_UMAP()` / `bc_FeaturePlot()`: Visualization tools for drug response data.
- `GetDiffGenes()`: Statistical testing for differential drug sensitivity.

## Tips
- **Input Data**: Ensure your scRNA-seq data is normalized before running `beyondcellScore`.
- **Memory**: Processing large scRNA-seq datasets with many drug signatures can be memory-intensive; consider downsampling if necessary.
- **Integration**: Beyondcell is designed to be compatible with the Seurat ecosystem, making it easy to move between transcriptomic and therapeutic analysis.

## Reference documentation
- [README](./references/README.md)
- [CHANGELOG](./references/CHANGELOG.md)
- [Home Page](./references/home_page.md)