---
name: bioconductor-mouse430a2frmavecs
description: This package provides frozen parameter vectors for performing Frozen Robust Multi-array Analysis on Affymetrix Mouse Genome 430 2.0 microarray data. Use when user asks to normalize single arrays or batches using fRMA, calculate quality metrics with GNUSE, or retrieve pre-computed probe effect vectors for the mouse430a2 platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mouse430a2frmavecs.html
---

# bioconductor-mouse430a2frmavecs

name: bioconductor-mouse430a2frmavecs
description: Provides frozen parameter vectors for the Affymetrix Mouse Genome 430 2.0 Array (mouse430a2). Use this skill when performing Frozen Robust Multi-array Analysis (fRMA) on mouse430a2 microarray data to normalize single arrays or batches using pre-computed vectors.

# bioconductor-mouse430a2frmavecs

## Overview

The `mouse430a2frmavecs` package is a data-annotation package for R/Bioconductor. It contains the frozen parameter vectors required by the `frma` and `GNUSE` functions (from the `frma` package) to process Affymetrix Mouse Genome 430 2.0 arrays. These vectors allow for the normalization and summarization of individual arrays or small batches by leveraging information from a large training database, ensuring consistency across different studies.

## Usage and Workflow

### Loading the Data

The package provides two primary datasets depending on the CDF (Chip Definition File) being used:

1.  **Standard CDF**: For use with the default Affymetrix probe groupings.
2.  **Entrez Gene (Alternative) CDF**: For use with modified probe groupings mapping to Entrez IDs.

```r
# Load the package
library(mouse430a2frmavecs)

# Load vectors for standard mouse430a2
data(mouse430a2frmavecs)

# Load vectors for Entrez Gene version (if using alternative CDF)
data(mouse430a2mmentrezgfrmavecs)
```

### Integration with fRMA

This package is rarely used in isolation. It is designed to be passed to the `frma` function.

```r
library(frma)
library(mouse430a2frmavecs)

# Assuming 'affyBatch' is your loaded Mouse 430 2.0 data
# fRMA will automatically look for the correct vectors, 
# but you can specify them if needed.
eset <- frma(affyBatch, target = "core")
```

### Data Structure

The loaded objects are lists containing the following elements:
- `normVec`: Normalization vector.
- `probeVec`: Probe effect vector.
- `probeVarWithin`: Within-batch probe variance.
- `probeVarBetween`: Between-batch probe variance.
- `probesetSD`: Within-probeset standard deviation.
- `medianSE`: Median standard error for gene expression estimates.

To inspect the structure:
```r
str(mouse430a2frmavecs)
```

## Tips

- **Automatic Detection**: The `frma` package usually detects and loads the appropriate `frmavecs` package automatically based on the annotation of the input `AffyBatch` object.
- **Memory**: These objects are pre-computed; using them is significantly faster and requires less memory than performing standard RMA on a large collection of arrays.
- **GNUSE**: Use these vectors with the `GNUSE` function to calculate the Generalized Normalized Unscaled Standard Error, which is a quality metric for individual arrays.

## Reference documentation

- [mouse430a2frmavecs Reference Manual](./references/reference_manual.md)