---
name: bioconductor-hgu133abarcodevecs
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/hgu133abarcodevecs.html
---

# bioconductor-hgu133abarcodevecs

name: bioconductor-hgu133abarcodevecs
description: Use this skill when working with Affymetrix hgu133a (GPL96) microarray data and the Bioconductor 'barcode' package. This skill provides access to the parameter estimates required to convert absolute gene expression intensities into binary (expressed/unexpressed) states using the barcode method.

## Overview

The `hgu133abarcodevecs` package is a data-only experiment package for R/Bioconductor. It contains the pre-computed parameter estimates (mu and tau vectors) specifically for the Affymetrix Human Genome U133A (hgu133a) platform. These vectors are essential for the `barcode` function in the `barcode` package, which implements a statistical thresholding method to determine if a gene is expressed above background noise.

## Loading and Using Data

The primary asset in this package is the `bcparams-GPL96` dataset.

### Loading the Package
To use the data, first load the library:

```r
library(hgu133abarcodevecs)
```

### Accessing the Parameters
Load the specific parameter matrix for the hgu133a platform:

```r
data("bcparams-GPL96")
```

The object `bcparams-GPL96` is a matrix containing the estimates used by the barcode algorithm.

### Typical Workflow
This package is rarely used in isolation. It is typically called internally or referenced when using the `barcode` package on hgu133a expression data.

```r
library(barcode)
library(hgu133abarcodevecs)

# Assuming 'expression_data' is a matrix or ExpressionSet for hgu133a
# The barcode package will often look for these vectors automatically, 
# but they can be manually inspected or passed if required by specific workflows.
data("bcparams-GPL96")
head(`bcparams-GPL96`)
```

## Tips
- **Platform Specificity**: Only use this package for the **hgu133a** (GPL96) array. For hgu133plus2 or other arrays, different barcode vector packages (e.g., `hgu133plus2barcodevecs`) must be used.
- **Data Structure**: The matrix contains parameters for each probeset on the array, allowing for the calculation of the probability that a gene is expressed.

## Reference documentation
- [hgu133abarcodevecs Reference Manual](./references/reference_manual.md)