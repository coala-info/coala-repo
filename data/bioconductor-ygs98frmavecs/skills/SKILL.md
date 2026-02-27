---
name: bioconductor-ygs98frmavecs
description: This package provides frozen parameter vectors for performing Frozen Robust Multi-array Analysis on Yeast Genome S98 microarray data. Use when user asks to preprocess ygs98 Affymetrix arrays, run the fRMA algorithm, or calculate GNUSE scores for yeast genome data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ygs98frmavecs.html
---


# bioconductor-ygs98frmavecs

name: bioconductor-ygs98frmavecs
description: Provides frozen parameter vectors for the Yeast Genome S98 (ygs98) platform. Use this skill when performing Frozen Robust Multi-array Analysis (fRMA) on Affymetrix ygs98 microarray data using the 'frma' or 'GNUSE' functions.

# bioconductor-ygs98frmavecs

## Overview

The `ygs98frmavecs` package is a data-only annotation package for Bioconductor. It contains the frozen parameter vectors required to run the fRMA algorithm on Yeast Genome S98 arrays. fRMA allows for the preprocessing of individual arrays or small batches by leveraging information from a large database of previously analyzed arrays, ensuring consistency across different studies.

## Usage

This package is primarily used as a dependency by the `frma` package. You do not typically call functions from this package directly, but rather load the data vectors it provides.

### Loading the Vectors

To manually inspect or load the frozen vectors into your R session:

```r
library(ygs98frmavecs)

# Load the standard vectors
data(ygs98frmavecs)

# Load the Entrez Gene alternative CDF version (if using alternative mapping)
data(ygs98scentrezgfrmavecs)
```

### Data Structure

The loaded objects are lists containing the following components:

- `normVec`: Normalization vector.
- `probeVec`: Probe effect vector.
- `probeVarWithin`: Within-batch probe variance.
- `probeVarBetween`: Between-batch probe variance.
- `probesetSD`: Within-probeset standard deviation.
- `medianSE`: Median standard error for gene expression estimates.

### Workflow Integration

To use these vectors in an fRMA analysis, ensure the package is installed and then specify the target platform in the `frma` call. The `frma` package will automatically detect and use these vectors when processing `ygs98` data.

```r
library(frma)
library(ygs98frmavecs)

# Assuming 'data' is an AffyBatch object for ygs98
# fRMA will automatically look for ygs98frmavecs
eset <- frma(data)
```

## Reference documentation

- [ygs98frmavecs Reference Manual](./references/reference_manual.md)