---
name: bioconductor-hthgu133afrmavecs
description: This package provides frozen parameter vectors for performing Frozen Robust Multi-array Analysis on the Affymetrix Human Genome HT-U133A platform. Use when user asks to perform fRMA preprocessing, calculate gene-specific normalized unscaled standard error, or normalize hthgu133a microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hthgu133afrmavecs.html
---


# bioconductor-hthgu133afrmavecs

name: bioconductor-hthgu133afrmavecs
description: Provides frozen parameter vectors for the Human Genome HT-U133A platform. Use this skill when performing Frozen Robust Multi-array Analysis (fRMA) or calculating Gene-specific Normalized Unscaled Standard Error (GNUSE) for hthgu133a microarray data using the 'frma' package.

# bioconductor-hthgu133afrmavecs

## Overview

The `hthgu133afrmavecs` package is a data-annotation package for Bioconductor. It contains the pre-computed "frozen" parameter vectors required to run the `frma` algorithm on Affymetrix Human Genome HT-U133A arrays. These vectors allow for the preprocessing of individual arrays or small batches by leveraging information from a large training database, ensuring consistency across different studies.

## Usage

This package is primarily used as a dependency for the `frma` package. You do not typically call functions within this package directly, but rather load the data vectors it provides.

### Loading the Vectors

To use these vectors in an fRMA pipeline, load the dataset corresponding to your CDF (standard or Entrez Gene):

```r
# Load the standard vectors
library(hthgu133afrmavecs)
data(hthgu133afrmavecs)

# Load the Entrez Gene alternative CDF version (if applicable)
data(hthgu133ahsentrezgfrmavecs)
```

### Integration with frma

The most common workflow involves passing the platform name to the `frma` function, which internally utilizes these vectors:

```r
library(frma)
library(hthgu133acdf) # Ensure the appropriate CDF is installed

# Assuming 'affyBatch' is your loaded HT-U133A data
object <- frma(affyBatch, target = "core")
```

### Data Structure

The loaded objects are lists containing the following elements used by the fRMA algorithm:
- `normVec`: Normalization vector.
- `probeVec`: Probe effect vector.
- `probeVarWithin`: Within-batch probe variance.
- `probeVarBetween`: Between-batch probe variance.
- `probesetSD`: Within-probeset standard deviation.
- `medianSE`: Median standard error for gene expression estimates.

To inspect the structure:
```r
str(hthgu133afrmavecs)
```

## Tips

- **Platform Match**: Ensure your data was generated on the `hthgu133a` platform. Using these vectors on data from different arrays (like the standard `hgu133a`) will result in incorrect normalization.
- **Memory**: These objects are data-heavy; only load them when performing the preprocessing step.

## Reference documentation

- [hthgu133afrmavecs Reference Manual](./references/reference_manual.md)