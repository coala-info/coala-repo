---
name: bioconductor-hugene.1.0.st.v1frmavecs
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hugene.1.0.st.v1frmavecs.html
---

# bioconductor-hugene.1.0.st.v1frmavecs

name: bioconductor-hugene.1.0.st.v1frmavecs
description: Provides frozen parameter vectors and background distribution data for the Affymetrix Human Gene 1.0 ST v1 array. Use this skill when performing Frozen Robust Multi-array Analysis (fRMA), calculating Gene-specific Non-Unbiased Standard Error (GNUSE), or using the barcode function for this specific microarray platform.

# bioconductor-hugene.1.0.st.v1frmavecs

## Overview

The `hugene.1.0.st.v1frmavecs` package is a data-only annotation package for Bioconductor. It contains the "frozen" parameter vectors required to run the `frma` algorithm on Affymetrix Human Gene 1.0 ST v1 arrays. By using these pre-computed vectors, researchers can preprocess individual arrays or small batches while maintaining consistency with a large training database, avoiding the batch effects typically introduced by standard RMA when datasets are combined.

## Usage and Workflows

### Loading the Data Vectors
The package primarily provides two sets of vectors: one for fRMA preprocessing and one for the gene expression barcode algorithm.

```r
# Load the fRMA vectors
library(hugene.1.0.st.v1frmavecs)
data(hugene.1.0.st.v1frmavecs)

# Load the barcode vectors
data(hugene.1.0.st.v1barcodevecs)
```

### Integration with fRMA
The most common use case is passing these vectors to the `frma` function from the `frma` package. While `frma` often detects the correct vectors automatically based on the CDF name, you can specify them manually if needed.

```r
library(frma)
library(hugene.1.0.st.v1cdf) # Ensure the CDF is available

# Standard fRMA preprocessing
# 'object' is an AffyBatch or FeatureSet
expression_set <- frma(object, target = "core") 
```

### Data Structures

#### hugene.1.0.st.v1frmavecs
This list contains 8 elements used for normalization and summarization:
- `normVec`: Vector used for quantile normalization.
- `probeVec`: Probe effect vector.
- `probeVarWithin`: Within-batch probe variance.
- `probeVarBetween`: Between-batch probe variance.
- `probesetSD`: Within-probeset standard deviation.
- `medianSE`: Median standard error for expression estimates.
- `probeVecCore`: Exon effect vector for core transcript summarization.
- `mapCore`: Mapping between exons and core transcripts.

#### hugene.1.0.st.v1barcodevecs
This list contains 3 elements used by the `barcode` function:
- `mu`: Background means.
- `tau`: Background standard deviations.
- `entropy`: Observed gene entropy.

### Quality Control with GNUSE
The vectors in this package allow for the calculation of GNUSE (Gene-specific Non-Unbiased Standard Error), which is a measure of array quality relative to the frozen distribution.

```r
# Calculate GNUSE scores
gnuse_scores <- GNUSE(object)
```

## Reference documentation

- [hugene.1.0.st.v1frmavecs Reference Manual](./references/reference_manual.md)