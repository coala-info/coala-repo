---
name: bioconductor-bladderbatch
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/bladderbatch.html
---

# bioconductor-bladderbatch

name: bioconductor-bladderbatch
description: A data package containing gene expression data from a bladder cancer study, specifically processed for demonstrating batch effect removal. Use this skill when you need to access the `bladderEset` ExpressionSet object for benchmarking, testing batch correction algorithms (like sva or ComBat), or performing differential expression analysis on bladder cancer microarray data.

## Overview

The `bladderbatch` package provides a curated `ExpressionSet` containing RMA-normalized gene expression data from 57 bladder samples. This dataset is the primary example used in the `sva` (Surrogate Variable Analysis) Bioconductor package because it contains well-documented batch effects related to the date the microarrays were processed.

The dataset includes:
- **Expression Data**: RMA-normalized values for 22,283 probesets.
- **Phenotypic Data**: 57 samples with variables for sample ID, original study outcome, batch ID, and a simplified cancer status.

## Loading and Inspecting Data

To use the dataset, load the library and call the `bladderdata` object.

```r
# Load the package
library(bladderbatch)

# Load the dataset into the workspace
data(bladderdata)

# The object is named 'bladderEset'
bladderEset
```

## Accessing Components

The data is stored as an `ExpressionSet`. Use standard Biobase methods to extract the relevant matrices and data frames.

```r
# Extract the expression matrix (probesets x samples)
edata <- exprs(bladderEset)

# Extract the sample metadata (phenoData)
pdata <- pData(bladderEset)

# View the first few rows of metadata
head(pdata)
```

### Metadata Variables
- `sample`: The unique sample identifier.
- `outcome`: The specific clinical outcome/stage from the original study.
- `batch`: The processing batch (1 through 5), essential for batch effect modeling.
- `cancer`: A simplified factor indicating "Cancer" vs "Normal".

## Common Workflows

### Preparing for Batch Correction (sva/ComBat)
This dataset is frequently used to demonstrate the removal of batch effects while preserving biological variation (cancer status).

```r
library(sva)
library(bladderbatch)
data(bladderdata)

# Get data
edata <- exprs(bladderEset)
pdata <- pData(bladderEset)

# Create model matrices
# Full model: adjust for the variable of interest (cancer)
mod <- model.matrix(~as.factor(cancer), data = pdata)
# Null model: adjustment variables only (none here, just intercept)
mod0 <- model.matrix(~1, data = pdata)

# Example: ComBat batch correction
batch <- pdata$batch
combat_edata <- ComBat(dat = edata, batch = batch, mod = mod)
```

### Differential Expression Analysis
You can use the data directly with `limma` to find genes associated with cancer status.

```r
library(limma)
design <- model.matrix(~cancer, data = pData(bladderEset))
fit <- lmFit(exprs(bladderEset), design)
fit <- eBayes(fit)
topTable(fit)
```

## Reference documentation

- [The bladderbatch data User's Guide](./references/bladderbatch.md)