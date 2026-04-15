---
name: bioconductor-nullrangesdata
description: This package provides standardized genomic datasets including DNase hypersensitivity sites, single-cell multiome data, and CTCF binding interactions for testing and demonstration. Use when user asks to access example genomic datasets, load DHS peaks or CTCF interactions, or retrieve sample data for null hypothesis testing and genomic overlap analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/nullrangesData.html
---

# bioconductor-nullrangesdata

name: bioconductor-nullrangesdata
description: Provides example datasets for the nullranges package, including DNase hypersensitivity sites (DHS), single-cell multiome ATAC/RNA data, and CTCF binding and genomic interaction data. Use when needing standardized genomic datasets for testing null hypothesis generation, overlap enrichment, or genomic interaction analysis.

# bioconductor-nullrangesdata

## Overview
The `nullrangesData` package is a data-experiment package that provides various genomic datasets used primarily in the vignettes of the `nullranges` package. It includes `GRanges` and `GInteractions` objects representing DNase hypersensitivity sites (DHS), single-cell multiome data (ATAC + Gene Expression), and CTCF binding sites/interactions.

## Loading the Package
Load the package to access the data loading functions:

```r
library(nullrangesData)
library(GenomicRanges)
library(InteractionSet)
```

## Accessing Datasets

### DNase Hypersensitivity Sites (DHS)
Access A549 cell line DHS peaks (hg38) using the accessor function. This data is retrieved via `ExperimentHub`.

```r
dhs <- DHSA549Hg38()
# Returns a GRanges object with signalValue, pValue, and qValue metadata
```

### Single Cell Multiome (ATAC + RNA)
Load single-cell data using the standard `data()` function. These datasets represent Chromium Single Cell Multiome ATAC + Gene Expression assays.

```r
data("sc_rna")      # GRanges with gene counts
data("sc_promoter") # GRanges with promoter ATAC counts

# View the NumericList counts in metadata
mcols(sc_rna)$counts1
```

### CTCF Bins and Interactions
Access 10kb genomic bins and CTCF-bound interaction pairs (hg19). These are useful for testing "bootstrapping" or "matching" workflows in `nullranges`.

```r
# 10kb bins with CTCF and DHS signals
bins <- hg19_10kb_bins()

# CTCF-bound genomic interaction pairs (StrictGInteractions)
binPairs <- hg19_10kb_ctcfBoundBinPairs()
```

## Typical Workflow
These datasets are typically used as "observed" or "pool" sets when generating null ranges:

1. **Matching**: Use `dhs` or `bins` to find sets of genomic features that match a target set on specific covariates (e.g., GC content or signal strength).
2. **Bootstrapping**: Use `binPairs` to perform block bootstrapping of genomic interactions to test for enrichment.
3. **Single-cell Analysis**: Use `sc_rna` and `sc_promoter` to demonstrate correlation or overlap between chromatin accessibility and gene expression.

## Tips
- Most datasets in this package are stored in `ExperimentHub`. The first time you call functions like `DHSA549Hg38()`, they will be downloaded and cached locally.
- Ensure `GenomicRanges` and `InteractionSet` are loaded to properly manipulate and visualize the returned objects.

## Reference documentation
- [nullrangesData](./references/nullrangesData.md)