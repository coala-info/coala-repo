---
name: bioconductor-single.mtec.transcriptomes
description: This package provides data and workflows for analyzing single-cell transcriptomes and promiscuous gene expression in mouse medullary thymic epithelial cells. Use when user asks to identify highly variable genes, analyze tissue-restricted antigens, perform k-medoids clustering on single-cell data, or investigate the genomic localization of co-expressed gene groups.
homepage: https://bioconductor.org/packages/release/data/experiment/html/Single.mTEC.Transcriptomes.html
---


# bioconductor-single.mtec.transcriptomes

name: bioconductor-single.mtec.transcriptomes
description: Analysis of single-cell RNA-seq and bulk ATAC-seq data from medullary thymic epithelial cells (mTECs). Use this skill to explore ectopic gene expression patterns, identify highly variable genes, analyze Tissue-Restricted Antigens (TRAs), and investigate gene-gene co-expression clusters in the thymus.

# bioconductor-single.mtec.transcriptomes

## Overview

The `Single.mTEC.Transcriptomes` package is an experiment data package containing the processed data and analysis workflows for studying the single-cell transcriptomes of mouse medullary thymic epithelial cells (mTECs). It focuses on the phenomenon of "promiscuous gene expression," where mTECs express thousands of tissue-restricted antigens (TRAs) to facilitate self-tolerance. The package provides tools to identify highly variable genes, perform k-medoids clustering on single-cell data, and analyze the genomic localization of co-expressed gene groups.

## Core Data Objects

Load the package and its primary datasets using `data()`:

- `mTECdxd`: A `DESeqDataSet` object containing the count matrix and cell annotations (e.g., SurfaceMarker, batch).
- `tras`: A list of genes defined as Tissue-Restricted Antigens.
- `geneNames`: A mapping between Ensembl IDs and common gene symbols.
- `biotypes`: Gene biotype annotations (e.g., protein_coding).
- `nomarkerCellsClustering`: Pre-calculated k-medoids clustering results for unselected mTECs.
- `scLVM_output`: Data corrected for cell-cycle effects using scLVM.
- `geneRanges`: Genomic coordinates for the genes analyzed.

## Key Workflows

### Identifying Variable Genes
To identify genes with biological variation exceeding technical noise:
```r
library(Single.mTEC.Transcriptomes)
data("mTECdxd")

# testForVar identifies genes with CV > 50% at a specific FDR
# Typically run on unselected cells (SurfaceMarker == "None")
deGenesNone = testForVar(
  countTable = counts(mTECdxd)[, colData(mTECdxd)$SurfaceMarker == "None"]
)
```

### TRA Analysis
Analyze the detection frequency of TRAs compared to protein-coding genes:
```r
data("tras")
data("biotypes")
isProteinCoding <- names(biotype == "protein_coding")
isTRA <- rownames(mTECdxd) %in% tras$gene.ids

# Calculate number of TRAs detected per cell
tra_counts <- colSums(counts(mTECdxd)[isTRA & rownames(mTECdxd) %in% isProteinCoding, ] > 0)
```

### Co-expression Clustering
The package uses k-medoids clustering to find groups of co-regulated genes (often Aire-dependent):
```r
data("nomarkerCellsClustering")
# Access consensus clustering IDs
cluster_ids <- cl_class_ids(nomarkerCellsClustering$consensus)

# Visualize gene-gene correlation matrices
# Use the internal heatmap.3 function (often provided in extfunction/ or via package)
```

### Genomic Localization
Investigate if co-expressed genes are physically clustered on chromosomes:
```r
data("geneRanges")
# Calculate median distance to nearest neighbor within a cluster
# Compare against null models generated via permutations
real_dist <- median(distanceToNearest(geneRanges[cluster_genes])@elementMetadata$distance)
```

## Analysis Tips
- **Cell Cycle Correction**: Single-cell correlations in mTECs are often confounded by the cell cycle. Use the `scLVM` corrected data (`Ycorr`) for gene-gene correlation analysis.
- **Surface Markers**: The dataset includes cells selected via FACS for specific markers like `Tspan8`, `Ceacam1`, and `Klk5`. These are used to validate co-expression groups identified in unselected cells.
- **Z-scores**: When visualizing co-expression groups in heatmaps, calculate Z-scores after regressing out cell cycle variation to highlight specific expression blocks.

## Reference documentation
- [Single-cell transcriptome analysis reveals coordinated ectopic-gene expression patterns in medullary thymic epithelial cells](./references/mTECs.md)