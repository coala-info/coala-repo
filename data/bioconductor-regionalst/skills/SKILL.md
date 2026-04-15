---
name: bioconductor-regionalst
description: RegionalST identifies biologically relevant regions of interest in spatial transcriptomics data based on cell type composition and tissue heterogeneity. Use when user asks to identify regions of interest, perform cross-regional differential expression analysis, or conduct pathway enrichment analysis on spatial transcriptomics data.
homepage: https://bioconductor.org/packages/release/bioc/html/RegionalST.html
---

# bioconductor-regionalst

## Overview

RegionalST is a Bioconductor package designed to address tissue heterogeneity in spatial transcriptomics (ST) data. It provides a workflow for identifying biologically relevant Regions of Interest (ROIs) based on cell type composition and performing comparative analysis between these regions. Key capabilities include:
- Integration with `BayesSpace` for data preprocessing.
- ROI identification using automated entropy-based ranking or manual selection.
- Cross-regional differential expression (DE) analysis that accounts for cell type proportions.
- Pathway enrichment analysis (GSEA) specifically tailored for regional comparisons.

## Workflow and Key Functions

### 1. Data Preparation
RegionalST utilizes the `SingleCellExperiment` (SCE) object format. It is highly compatible with `BayesSpace` for initial loading and preprocessing.

```r
library(RegionalST)
library(BayesSpace)

# Load Visium data
sce <- readVisium("path/to/spaceranger/outs/")
sce <- spatialPreprocess(sce, platform="Visium", log.normalize=TRUE)

# Add cell type proportions (from deconvolution tools like CARD or RCTD)
# Proportions should be stored in metadata(sce)$Proportions
S4Vectors::metadata(sce)$Proportions <- my_deconvolution_results
```

### 2. Identifying Regions of Interest (ROIs)
ROIs are identified by calculating entropy across the tissue. You can assign weights to specific cell types (e.g., giving higher weight to Cancer Epithelial cells) to bias ROI selection toward specific biological features.

**Weighted Entropy Calculation:**
```r
weight <- data.frame(celltype = c("Cancer Epithelial", "CAFs", "T-cells"),
                     weight = c(0.25, 0.05, 0.25))

# Calculate entropy for a specific radius
OneRad <- GetOneRadiusEntropy_withProp(sce, radius = 5, weight = weight, doPlot = TRUE)
```

**Automatic ROI Selection:**
Ranks centers by entropy and ensures a minimum distance (`min_radius`) between selected regions.
```r
sce <- RankCenterByEntropy_withProp(sce, weight, topN = 3, min_radius = 10, radius_vec = c(5, 10))
```

**Manual ROI Selection:**
Launches a Shiny app for interactive selection.
```r
sce <- ManualSelectCenter(sce)
```

### 3. Cross-Regional Differential Analysis
Once ROIs are defined, compare gene expression between them.

**With Cell Type Proportions:**
```r
# Compare Region 1 and Region 2
CR_DE <- GetCrossRegionalDE_withProp(sce, twoCenter = c(1, 2), label = "celltype", padj_filter = 0.05, doHeatmap = TRUE)
```

**With Discrete Cell Type Labels:**
If deconvolution is unavailable, use major cell type labels per spot.
```r
CR_DE_raw <- GetCrossRegionalDE_raw(sce, twoCenter = c(1, 2), label = "celltype")
```

### 4. Pathway Analysis (GSEA)
Perform GSEA on the results of the cross-regional DE analysis. Supported databases include "hallmark", "kegg", and "reactome".

```r
# Perform GSEA
res_list <- list(CR_DE)
gsea_res <- DoGSEA(res_list, whichDB = "hallmark", withProp = TRUE)

# Visualize results for a specific cell type (e.g., index 1)
DrawDotplot(gsea_res, CT = 1, chooseP = "padj")
```

## Tips for Success
- **Radius Selection:** The `radius` parameter in entropy functions determines the local neighborhood size. Smaller radii capture fine-grained heterogeneity, while larger radii capture broader tissue patterns.
- **Weighting:** If you are looking for regions where specific rare cell types interact, increase the `weight` for those cell types in the weight data frame.
- **Memory Management:** For large datasets, use the `selectN` argument in `GetOneRadiusEntropy` to calculate entropy on a subset of spots to speed up visualization.
- **ROI Storage:** Selected centers are stored in `metadata(sce)$selectCenters`. Save this object to ensure reproducibility of regional analyses.

## Reference documentation
- [Understanding Intrasample Heterogeneity from ST data with RegionalST](./references/RegionalST.md)