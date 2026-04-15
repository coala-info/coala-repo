---
name: bioconductor-scdataviz
description: bioconductor-scdataviz provides specialized visualization and analysis tools for high-dimensional single-cell data such as CyTOF, flow cytometry, and scRNA-seq. Use when user asks to process FCS files, perform dimensionality reduction, identify cell clusters via k-NN, or generate publication-quality plots like contour plots and marker expression maps.
homepage: https://bioconductor.org/packages/release/bioc/html/scDataviz.html
---

# bioconductor-scdataviz

name: bioconductor-scdataviz
description: Specialized visualization and analysis for single-cell data, including CyTOF, flow cytometry, and scRNA-seq. Use this skill to process FCS files, perform dimensionality reduction (PCA/UMAP), identify cell clusters via k-NN, and generate publication-quality plots such as contour plots, marker expression maps, and cluster signatures.

# bioconductor-scdataviz

## Overview
scDataviz is a Bioconductor package designed to simplify the visualization and downstream analysis of high-dimensional single-cell data. It is built upon the `SingleCellExperiment` (SCE) class and uses the `ggplot2` engine, allowing for "plug-and-play" compatibility with other Bioconductor workflows and easy customization of graphics. It is particularly useful for researchers working with flow and mass cytometry (CyTOF) data who need to identify cell populations and visualize marker distributions.

## Core Workflow

### 1. Data Input and Preprocessing
You can import data from raw FCS files or from existing numerical matrices.

**From FCS files:**
Use `processFCS` to read, transform (e.g., asinh), and downsample data.
```r
library(scDataviz)
sce <- processFCS(
  files = filelist,
  metadata = metadata_df,
  transformation = TRUE,
  transFun = function(x) asinh(x),
  asinhFactor = 5,
  downsample = 10000,
  colsRetain = inclusions,
  newColnames = markernames
)
```

**From a Matrix:**
```r
sce <- importData(mat, assayname = 'normcounts', metadata = metadata_df)
```

**From Seurat:**
```r
library(Seurat)
sce <- as.SingleCellExperiment(seurat_obj)
metadata(sce) <- data.frame(colData(sce)) # Ensure metadata slot is populated
```

### 2. Dimensionality Reduction
scDataviz supports PCA (via `PCAtools`) and UMAP.

```r
# PCA
library(PCAtools)
p <- pca(assay(sce, 'scaled'), metadata = metadata(sce))
reducedDim(sce, 'PCA') <- p$rotated

# UMAP (on expression values)
sce <- performUMAP(sce)

# UMAP (on PC eigenvectors)
sce <- performUMAP(sce, reducedDim = 'PCA', dims = 1:5)
```

### 3. Visualization
The package provides several specialized plotting functions.

*   **Contour Plots:** Visualize cellular density to identify "islands."
    ```r
    contourPlot(sce, reducedDim = 'UMAP', bins = 150)
    ```
*   **Marker Expression:** Map specific marker levels onto the UMAP/PCA layout.
    ```r
    markerExpression(sce, markers = c('CD4', 'CD8', 'Foxp3'), reducedDim = 'UMAP')
    ```
*   **Metadata Plot:** Shade cells by categorical variables (e.g., Treatment, Genotype).
    ```r
    metadataPlot(sce, colby = 'group', colkey = c(Healthy='blue', Disease='red'))
    ```

### 4. Clustering and Enrichment
Identify cell populations using k-nearest neighbors (k-NN) and characterize them.

```r
# Clustering
sce <- clusKNN(sce, k.param = 20, resolution = 0.01, algorithm = 2)

# Visualize Clusters
plotClusters(sce, clusterColname = 'Cluster', labSize = 5)

# Marker Enrichment (identifies Pos/Neg markers per cluster)
enrichment <- markerEnrichment(sce, method = 'quantile', studyvarID = 'group')

# Expression Signatures (Heatmap of marker expression per cluster)
plotSignatures(sce, labCex = 1.2)
```

## Tips for Success
*   **Marker Naming:** Ensure marker names are consistent. FCS files often use metal isotopes (e.g., "Nd143Di") as column names; use the `newColnames` argument in `processFCS` to map these to biological names (e.g., "CD45RA").
*   **Assay Selection:** Most functions default to the `scaled` assay. If your data is in `logcounts` or `normcounts`, specify the `assay` parameter in the function call.
*   **UMAP Tuning:** You can pass a `config` object from the `umap` package to `performUMAP` to adjust parameters like `min_dist` or `n_neighbors`.
*   **Interoperability:** Since the output is a `SingleCellExperiment` object, you can seamlessly transition to other tools like `scran`, `scater`, or `ComplexHeatmap`.

## Reference documentation
- [scDataviz: single cell dataviz and downstream analyses](./references/scDataviz.Rmd)
- [scDataviz: single cell dataviz and downstream analyses](./references/scDataviz.md)