---
name: bioconductor-scanmirdata
description: This package provides pre-computed miRNA binding affinity models for human, mouse, and rat to be used with scanMiR. Use when user asks to load miRNA KdModels, filter miRNA models by conservation category, or retrieve miRBase binding data for sequence scanning.
homepage: https://bioconductor.org/packages/release/data/experiment/html/scanMiRData.html
---


# bioconductor-scanmirdata

## Overview

The `scanMiRData` package is a data experiment package that provides pre-computed `KdModel` and `KdModelList` objects for all miRBase miRNAs in human, mouse, and rat. These models represent miRNA binding affinities predicted using Convolutional Neural Networks (CNN). This package is designed to be used in conjunction with the `scanMiR` package to perform sequence scanning and binding site prediction.

## Loading and Filtering Models

There are two primary ways to access the miRNA models: using the standard R `data()` function or the package-specific `getKdModels()` helper.

### Using getKdModels (Recommended)

The `getKdModels` function is the most flexible method as it allows for immediate filtering by conservation category.

```r
library(scanMiRData)

# Load all mouse models
mmu <- getKdModels("mmu")

# Load specific species with conservation filtering
# Options: "Conserved across vertebrates", "Conserved across mammals", "Poorly conserved", "Low-confidence"
hsa_conserved <- getKdModels("hsa", categories=c("Conserved across vertebrates", 
                                               "Conserved across mammals"))

summary(hsa_conserved)
```

### Using data()

You can load the full collections directly into your environment. The objects are named by their species code (hsa, mmu, or rno).

```r
library(scanMiR)
library(scanMiRData)

# Load mouse models
data("mmu", package="scanMiRData")

# Inspect the collection
summary(mmu)
head(mmu)
```

## Supported Species

The package contains collections for three major model organisms:
- `hsa`: Homo sapiens (Human)
- `mmu`: Mus musculus (Mouse)
- `rno`: Rattus norvegicus (Rat)

## Workflow Integration

Once loaded, these `KdModelList` objects are typically passed to `scanMiR` functions for scanning sequences:

```r
library(scanMiR)
library(scanMiRData)

# 1. Get models
mods <- getKdModels("hsa", categories="Conserved across vertebrates")

# 2. Use with scanMiR (example workflow)
# hits <- findSeedMatches(target_sequence, mods)
```

## Reference documentation

- [scanMiRData](./references/scanMiRData.md)