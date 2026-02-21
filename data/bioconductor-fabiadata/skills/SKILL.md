---
name: bioconductor-fabiadata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/fabiaData.html
---

# bioconductor-fabiadata

name: bioconductor-fabiadata
description: Provides gene expression datasets for biclustering demonstrations and testing. Use this skill to load and prepare specific microarray datasets (Breast Cancer, Lymphoma, and Multiple Tissue types) for use with the FABIA (Factor Analysis for Bicluster Acquisition) algorithm or other biclustering methods.

## Overview

The `fabiaData` package is a data-only experiment package for Bioconductor. It contains three primary gene expression datasets used to demonstrate the capabilities of the `fabia` biclustering package. These datasets include pre-defined subclass labels, making them ideal for validating biclustering results against known biological groups.

## Loading Data and Workflows

To use these datasets, you must load both the data package and the main `fabia` analysis package.

### 1. Breast Cancer Dataset (van't Veer)
Used for finding gene signatures and subclasses in breast cancer therapy outcomes.
- **Load command**: `data(Breast_A)`
- **Data object**: `XBreast` (97 samples x 1213 genes)
- **Class labels**: `CBreast` (3 subclasses)

```r
library(fabia)
library(fabiaData)
data(Breast_A)
X <- as.matrix(XBreast)
# Example analysis
res <- fabia(X, p=5, alpha=0.1, iter=400)
```

### 2. Diffuse Large-B-Cell Lymphoma (Rosenwald)
Used to identify subclasses related to oxidative phosphorylation (OxPhos), B-cell response (BCR), and host response (HR).
- **Load command**: `data(DLBCL_B)`
- **Data object**: `XDLBCL` (180 samples x 661 genes)
- **Class labels**: `CDLBCL` (3 subclasses)

```r
data(DLBCL_B)
X <- as.matrix(XDLBCL)
res <- fabias(X, p=5, alpha=0.6, iter=300)
```

### 3. Multiple Tissue Types (Su)
Contains human and mouse samples across diverse tissues to identify tissue-specific transcriptomes.
- **Load command**: `data(Multi_A)`
- **Data object**: `XMulti` (102 samples x 5565 genes)
- **Class labels**: `CMulti` (4 subclasses)

```r
data(Multi_A)
X <- as.matrix(XMulti)
res <- mfsc(X, p=5, iter=100)
```

## Interpreting and Visualizing Results

After running a biclustering algorithm from the `fabia` package on these datasets, use the following workflow to evaluate the results against the provided class labels:

1. **Extract Biclusters**: Use `extractBic(res)` to get the row and column indices of the discovered biclusters.
2. **Plot Biclusters**: Use `plotBicluster(ra, n)` where `n` is the bicluster index.
3. **Compare with Labels**: Use the `plot` function with the `col.group` parameter set to the class label object (e.g., `CBreast`, `CDLBCL`, or `CMulti`) to see if the biclusters align with known biological groups.

```r
# Example visualization with labels
plot(res, dim=c(1,2), col.group=CBreast, label.tol=0.03)
```

## Reference documentation

- [fabiaData](./references/fabiaData.md)