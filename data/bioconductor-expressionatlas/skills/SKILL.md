---
name: bioconductor-expressionatlas
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ExpressionAtlas.html
---

# bioconductor-expressionatlas

## Overview
The `ExpressionAtlas` package provides an interface to the EMBL-EBI Expression Atlas, a repository of high-quality, manually curated, and re-analyzed datasets. It allows users to programmatically search for experiments based on biological attributes (e.g., "salt stress", "liver") and species, then download the data as standard Bioconductor objects.

## Typical Workflow

### 1. Searching for Experiments
Use `searchAtlasExperiments()` to find datasets. The `properties` argument accepts character vectors of sample attributes or treatments.

```r
library(ExpressionAtlas)

# Search for salt-related experiments in rice (Oryza sativa)
atlasRes <- searchAtlasExperiments(properties = "salt", species = "oryza")

# View results (Accession, Species, Type, Title)
head(atlasRes)
```

### 2. Downloading Data
You can download data for multiple accessions using `getAtlasData()` or a single accession using `getAtlasExperiment()`.

```r
# Download multiple experiments into a SimpleList
allExps <- getAtlasData(atlasRes$Accession[1:3])

# Download a specific experiment
mtab3007 <- getAtlasExperiment("E-MTAB-3007")
```

### 3. Accessing Data Objects
The downloaded data is returned as a `SimpleList`. The internal structure depends on the experiment type:

#### RNA-seq Data
RNA-seq experiments are stored as `RangedSummarizedExperiment` objects under the name `rnaseq`.
- **Counts:** `assays(exp$rnaseq)$counts`
- **Sample Metadata:** `colData(exp$rnaseq)`
- **Processing Info:** `metadata(exp$rnaseq)`

```r
# Example for RNA-seq
se <- allExps[["E-MTAB-1625"]]$rnaseq
counts_matrix <- assays(se)$counts
sample_info <- colData(se)
```

#### Microarray Data
Microarray experiments are stored as `ExpressionSet` objects, indexed by the array design accession (e.g., "A-AFFY-126").
- **Intensities:** `exprs(exp[["A-AFFY-126"]])`
- **Sample Metadata:** `pData(exp[["A-AFFY-126"]])`
- **Normalization Info:** `preproc(experimentData(exp[["A-AFFY-126"]]))`

```r
# Example for Microarray
eset <- allExps[["E-MTAB-1624"]][["A-AFFY-126"]]
intensity_matrix <- exprs(eset)
sample_info <- pData(eset)
```

## Tips for Success
- **Filtering Results:** Use `grep` on the `Type` column of search results to distinguish between "RNA-seq of coding RNA" and "transcription profiling by array" before downloading.
- **Species Names:** Use scientific names or common substrings (e.g., "homo" or "human") in the `species` argument.
- **Data Types:** Remember that RNA-seq data provides **raw counts**, whereas microarray data provides **normalized intensities**.

## Reference documentation
- [Expression Atlas package vignette](./references/ExpressionAtlas.md)