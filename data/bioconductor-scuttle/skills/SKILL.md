---
name: bioconductor-scuttle
description: This tool provides fundamental utility functions for quality control, normalization, and data manipulation in single-cell RNA-seq analysis. Use when user asks to perform quality control on cells, compute size factors for normalization, aggregate cells into pseudobulks, or convert SingleCellExperiment objects for visualization.
homepage: https://bioconductor.org/packages/release/bioc/html/scuttle.html
---

# bioconductor-scuttle

name: bioconductor-scuttle
description: Low-level utilities for single-cell RNA-seq data analysis. Use this skill for quality control (QC) of cells and features, scaling normalization (size factors), aggregating cells into pseudobulks, and converting SingleCellExperiment objects to data frames for visualization.

# bioconductor-scuttle

## Overview
The `scuttle` package provides fundamental utility functions for single-cell RNA-seq (scRNA-seq) analysis. It is primarily used at the beginning of a pipeline for quality control and normalization, or for data manipulation tasks like aggregating cells by cluster or converting data into formats compatible with `ggplot2`.

## Quality Control (QC)
QC identifies and removes low-quality cells (e.g., damaged or empty droplets) based on library size, number of detected genes, and mitochondrial content.

### Automated QC
The fastest way to perform QC is using `quickPerCellQC`.
```r
library(scuttle)
# subsets: list of logical/integer vectors or row names (e.g., mitochondrial genes)
# sub.fields: which subsets to use for outlier detection
sce <- quickPerCellQC(sce, subsets=list(Mito=grep("^mt-", rownames(sce), ignore.case=TRUE)))
```

### Manual QC Workflow
1. **Compute metrics**: `perCellQCMetrics` calculates sums and detection rates.
2. **Identify outliers**: `isOutlier` uses Median Absolute Deviations (MADs).
3. **Filter**: Remove cells marked as outliers.

```r
stats <- perCellQCMetrics(sce, subsets=list(Mito=is.mito))
# Identify outliers 3 MADs away from the median
discard <- perCellQCFilters(stats, sub.fields="subsets_Mito_percent")
sce <- sce[, !discard$discard]
```

## Normalization
Normalization removes cell-specific biases (sequencing depth, capture efficiency) by computing size factors.

### Computing Size Factors
- **Library Size**: `librarySizeFactors(sce)` - Simple, fast, but sensitive to composition bias.
- **Pooled/Deconvolution**: `computePooledFactors(sce, clusters=clusters)` - Robust to composition bias; requires prior clustering (e.g., from `scran::quickCluster`).
- **Spike-ins**: `computeSpikeFactors(sce, "ERCC")` - Preserves differences in total RNA content.

### Applying Normalization
Use `logNormCounts` to compute log2-transformed normalized expression values, stored in the "logcounts" assay.
```r
sce <- logNormCounts(sce)
# Access results
logcounts(sce)[1:5, 1:5]
```

## Aggregation and Pseudobulking
`aggregateAcrossCells` sums counts across groups (e.g., clusters or samples), which is essential for differential expression analysis using bulk-RNA-seq tools like `edgeR` or `DESeq2`.

```r
# Aggregate by cluster
agg.sce <- aggregateAcrossCells(sce, ids=sce$cluster)

# Aggregate by multiple factors (e.g., cluster AND sample)
agg.multi <- aggregateAcrossCells(sce, ids=colData(sce)[,c("cluster", "sample")])
```

## Utility Functions

### Memory-Efficient Data Loading
If a large dataset is stored as a dense text file (CSV/TSV), use `readSparseCounts` to load it directly into a sparse matrix without exhausting RAM.
```r
sparse.mat <- readSparseCounts("huge_data.tsv")
```

### Feature Name Management
Ensure row names are unique and human-readable while preserving original IDs.
```r
rownames(sce) <- uniquifyFeatureNames(ID=rowData(sce)$Ensembl, names=rowData(sce)$Symbol)
```

### Data Frame Conversion
Convert `SingleCellExperiment` data to a `data.frame` for use in `ggplot2` or `model.matrix`.
```r
# Create DF with metadata and specific gene expression
plot.df <- makePerCellDF(sce, features=c("PTPRC", "CD3E"))
```

## Reference documentation
- [Other single-cell RNA-seq analysis utilities](./references/misc.md)
- [Normalizing single-cell RNA-seq data](./references/norm.md)
- [Quality control for single-cell RNA-seq data](./references/qc.md)