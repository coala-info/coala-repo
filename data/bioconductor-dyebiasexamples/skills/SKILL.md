---
name: bioconductor-dyebiasexamples
description: This package provides example microarray datasets and utility functions to support the dyebias R package for gene-specific dye bias correction. Use when user asks to load example marray objects, convert GEO datasets for dye bias correction, or identify suitable probes for estimating slide bias.
homepage: https://bioconductor.org/packages/release/data/experiment/html/dyebiasexamples.html
---

# bioconductor-dyebiasexamples

name: bioconductor-dyebiasexamples
description: Provides example data and utility functions for the dyebias R package, which implements the GASSCO method for dye bias correction in two-color microarrays. Use this skill when you need to demonstrate, test, or develop workflows for gene-specific dye bias correction using marray objects or when converting GEO datasets for use with the dyebias package.

# bioconductor-dyebiasexamples

## Overview

The `dyebiasexamples` package provides the necessary data structures and helper functions to support the `dyebias` package. It contains real-world microarray data from self-self hybridizations of yeast slides and data from ArrayExpress (E-MTAB-32). Its primary purpose is to provide a standardized environment for testing the GASSCO (Gene-specific dye bias correction) method.

Key components include:
- **Example Data**: Pre-loaded `marrayRaw` and `marrayNorm` objects.
- **GEO Conversion**: Tools to transform Gene Expression Omnibus (GEO) objects into `marray` formats.
- **Estimator Selection**: Functions to identify suitable probes for calculating slide bias.

## Loading Example Data

The package provides two main datasets representing four hybridizations of identical mRNA with varying labeling percentages.

```r
library(dyebiasexamples)

# Load raw microarray data (marrayRaw object)
data(data.raw)

# Load normalized but uncorrected data (marrayNorm object)
# This was processed using print-tip LOESS normalization
data(data.norm)

# Inspect the experimental design
maInfo(maTargets(data.norm))
```

## Converting GEO Data

If working with data from the Gene Expression Omnibus, use `dyebias.geo2marray` to convert `GSE` objects into a format compatible with the `dyebias` correction workflow.

```r
# Example structure for conversion (requires GEOquery)
# my.marray <- dyebias.geo2marray(gse = gse_object, 
#                                 type = "norm", 
#                                 cy3.name = "Value_Ch1", 
#                                 cy5.name = "Value_Ch2")
```

## Selecting Bias Estimators

Before applying dye bias correction, you must identify which spots are "proper" estimators (i.e., excluding mitochondrial genes or cross-hybridizing probes).

```r
# Identify suitable estimators based on reporter information
estimator.subset <- dyebias.umcu.proper.estimators(maInfo(maGnames(data.norm)))

# View summary of how many probes are suitable
summary(estimator.subset)
```

## Typical Workflow

1. **Load Data**: Bring in the example `data.norm`.
2. **Define Estimators**: Use `dyebias.umcu.proper.estimators` to create a logical subset of probes.
3. **Apply Correction**: (Requires the `dyebias` package) Use the subset to calculate and apply the GASSCO correction.

```r
library(dyebias)
library(dyebiasexamples)

data(data.norm)

# 1. Determine which spots to use for estimating slide bias
estimators <- dyebias.umcu.proper.estimators(maInfo(maGnames(data.norm)))

# 2. Apply the correction (assuming iGSDBs are already estimated or available)
# correction <- dyebias.apply.correction(data.norm = data.norm,
#                                        estimator.subset = estimators,
#                                        application.subset = TRUE)
```

## Reference documentation

- [dyebiasexamples Reference Manual](./references/reference_manual.md)