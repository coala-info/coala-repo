---
name: bioconductor-irisfgm
description: IRIS-FGM is a Bioconductor package for analyzing single-cell RNA-seq data through co-expression gene module identification and regulatory signal modeling. Use when user asks to analyze single-cell RNA-seq data, identify co-expressed gene modules using biclustering, model regulatory signals with LTMG, or perform cell clustering and dimension reduction.
homepage: https://bioconductor.org/packages/3.13/bioc/html/IRISFGM.html
---


# bioconductor-irisfgm

## Overview
IRIS-FGM (Integrative and Interpretation System for co-expression Gene Module analysis) is a Bioconductor package designed for the analysis of single-cell RNA-seq (scRNA-seq) data. It specializes in identifying co-expressed gene modules using the QUBIC2 biclustering algorithm and modeling regulatory signals using the Left-Truncated Mixture Gaussian (LTMG) model. The package provides two primary workflows: a "quick mode" for standard cell clustering and a more intensive biclustering-based co-expression analysis.

## Core Workflow

### 1. Object Initialization and Preprocessing
The workflow begins by creating an `IRISFGM` object from an expression matrix (RPKM/FPKM/CPM preferred).

```r
library(IRISFGM)

# Create object (InputMatrix: genes in rows, cells in columns)
object <- CreateIRISFGMObject(InputMatrix)

# Optional: Add metadata (cell labels)
object <- AddMeta(object, meta.info = my_meta_df)

# Filter low quality cells/genes
object <- SubsetData(object, nFeature.upper = 2000, nFeature.lower = 250)

# Normalization and Imputation
# normalization options: 'cpm' (default) or 'scran'
object <- ProcessData(object, normalization = "cpm", IsImputation = FALSE)
```

### 2. Regulatory Signal Modeling (LTMG)
LTMG models the kinetic activity of gene transcription (on/off states).

```r
# Run LTMG on top variable genes (e.g., 500 or 2000) or "all"
object <- RunLTMG(object, Gene_use = "500")

# Extract the LTMG signal matrix
LTMG_Matrix <- GetLTMGmatrix(object)
```

### 3. Biclustering (QUBIC2)
This step identifies functional gene modules (FGMs) across subsets of cells.

```r
# Generate binary/multi-signal for biclustering
object <- CalBinaryMultiSignal(object)

# Run Biclustering
# DiscretizationModel can be "LTMG" or "Quantile"
object <- RunBicluster(object, DiscretizationModel = "LTMG", NumBlockOutput = 100)
```

### 4. Cell Clustering and Dimension Reduction
IRIS-FGM supports standard Seurat-style clustering and a specialized Markov Clustering (MCL) approach based on biclustering results.

```r
# Standard Dimension Reduction (UMAP or tSNE)
object <- RunDimensionReduction(object, mat.source = "UMImatrix", reduction = "umap")

# Seurat-based clustering
object <- RunClassification(object, k.param = 20, resolution = 0.8)

# Bicluster-based Markov Clustering (requires RunBicluster first)
object <- FindClassBasedOnMC(object)
```

### 5. Visualization and Interpretation
The package provides tools to visualize the relationships between modules and identify marker genes.

```r
# Plot overlapping gene modules
PlotNetwork(object, N.bicluster = c(1:20))

# Heatmap of specific biclusters
PlotHeatmap(object, N.bicluster = c(1, 5))

# Visualize cell clusters on UMAP
PlotDimension(object, reduction = "umap", idents = "MC_Label")

# Find and plot marker genes
global_marker <- FindGlobalMarkers(object, idents = "Seurat_r_0.8_k_20")
PlotMarkerHeatmap(Globalmarkers = global_marker, object = object)
```

## Key Functions Reference
- `CreateIRISFGMObject`: Initializes the S4 object.
- `RunLTMG`: Fits the Left-Truncated Mixture Gaussian model to capture regulatory signals.
- `RunBicluster`: Executes the QUBIC2 algorithm to find co-expression modules.
- `FindClassBasedOnMC`: Predicts cell types using Markov Clustering on the bicluster-weighted graph.
- `PlotModuleNetwork`: Visualizes gene correlation networks within a specific Functional Gene Module (FGM).

## Reference documentation
- [IRISFGM R package](./references/IRISFGM_Rpackage.md)