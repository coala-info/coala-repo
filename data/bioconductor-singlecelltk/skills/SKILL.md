---
name: bioconductor-singlecelltk
description: The singleCellTK package provides a comprehensive toolkit for the analysis, quality control, and visualization of single-cell RNA-seq data through both R command-line and interactive Shiny interfaces. Use when user asks to import scRNA-seq data, perform quality control, normalize counts, run dimensionality reduction, cluster cells, or conduct differential expression analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/singleCellTK.html
---

# bioconductor-singlecelltk

name: bioconductor-singlecelltk
description: Comprehensive toolkit for single-cell RNA-seq analysis. Use when performing quality control, normalization, batch correction, clustering, differential expression, and visualization of scRNA-seq data using the singleCellTK Bioconductor package. Supports both command-line R workflows and interactive Shiny GUI exploration.

## Overview
The singleCellTK (SCTK) package provides a unified interface for various single-cell RNA-sequencing (scRNA-seq) analysis methods. It utilizes the `SingleCellExperiment` (SCE) object as the primary data structure. SCTK integrates popular tools for QC (Scater, SoupX, DecontX), normalization, dimensionality reduction (PCA, UMAP, t-SNE), and clustering, allowing users to run complex pipelines with consistent function calls.

## Core Workflow

### 1. Data Import
SCTK supports various formats including Cell Ranger output, STARsolo, and built-in datasets.
```r
library(singleCellTK)
# Import example data
sce <- importExampleData("pbmc3k")

# Import Cell Ranger data
sce <- importCellRanger(cellRangerDirs = "path/to/dir", 
                        sampleDirs = "sample_name")
```

### 2. Quality Control (QC)
Run comprehensive QC pipelines that calculate metrics and identify outliers or contamination.
```r
# Run standard QC suite
sce <- runCellQC(sce, algorithms = c("scater", "decontX", "scrublet"))

# Visualize QC metrics
plotQCBarcodeRank(sce)
plotScaterQC(sce, slotName = "scater_qc")
```

### 3. Normalization and Feature Selection
```r
# Scran normalization
sce <- scranNormalize(sce)

# Identify highly variable genes
sce <- runModelGeneVar(sce)
```

### 4. Dimensionality Reduction and Clustering
SCTK wraps common algorithms for easy execution.
```r
# Dimensionality Reduction
sce <- runPCA(sce, useAssay = "logcounts")
sce <- runUMAP(sce, useReducedDim = "PCA")

# Clustering (e.g., using Seurat's Louvain algorithm)
sce <- runSeuratFindClusters(sce, useReducedDim = "PCA", resolution = 0.8)
```

### 5. Differential Expression (DE)
Perform DE analysis between clusters or conditions.
```r
sce <- runDEAnalysis(sce, 
                     method = "MAST", 
                     groupName1 = "cluster1", 
                     groupName2 = "cluster2",
                     index1 = which(colData(sce)$cluster == 1),
                     index2 = which(colData(sce)$cluster == 2),
                     analysisName = "C1_vs_C2")
```

### 6. Interactive Analysis
Launch the Shiny GUI to explore the data and results interactively.
```r
singleCellTK(sce)
```

## Tips for Success
- **Object Compatibility**: SCTK functions primarily return a `SingleCellExperiment` object with results stored in `colData`, `reducedDims`, or `metadata` slots.
- **Wrapper Functions**: Many functions start with `run...` (e.g., `runSeuratNormalize`, `runScaterQC`). These are wrappers that handle the conversion between SCTK and other package formats internally.
- **Assay Names**: Ensure you specify the correct `useAssay` (e.g., "counts", "logcounts") as required by the specific analysis function.

## Reference documentation
- [Introduction to singleCellTK](./references/singleCellTK.md)
- [singleCellTK Rmd](./references/singleCellTK.Rmd)