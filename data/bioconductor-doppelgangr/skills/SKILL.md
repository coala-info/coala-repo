---
name: bioconductor-doppelgangr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/doppelgangR.html
---

# bioconductor-doppelgangr

name: bioconductor-doppelgangr
description: Identify duplicate samples (doppelgängers) within or between transcriptome datasets (microarray or log-transformed RNA-seq). Use this skill when you need to detect potential sample overlaps, technical replicates, or mislabeled specimens across multiple Bioconductor ExpressionSet objects using expression correlation, phenotype similarity, or unique identifiers.

# bioconductor-doppelgangr

## Overview

The `doppelgangR` package is designed to identify "doppelgängers"—duplicate genomic profiles that may exist within a single study or across different public datasets (like GEO). It is particularly effective for cancer datasets where biological replicates are typically more distinct than technical duplicates. The tool uses three primary detection methods:
1.  **Expression Similarity**: Pearson correlation of gene expression profiles (with optional ComBat batch correction).
2.  **Phenotype Similarity**: Comparison of clinical metadata (phenoData).
3.  **Smoking Guns**: Identification of supposedly unique identifiers that appear in multiple samples.

## Typical Workflow

### 1. Data Preparation
Input data must be a list of `ExpressionSet` objects. If you have matrices, convert them using `Biobase`.

```r
library(doppelgangR)
library(Biobase)

# Convert matrices to ExpressionSets if necessary
eset1 <- ExpressionSet(assayData = matrix1)
eset2 <- ExpressionSet(assayData = matrix2)

# Create the input list
test_esets <- list(StudyA = eset1, StudyB = eset2)
```

### 2. Running the Identification
The main function is `doppelgangR()`. By default, it performs expression and phenotype checks.

```r
# Basic run (default settings)
results <- doppelgangR(test_esets)

# Run without phenotype checking (if metadata is not curated/standardized)
results <- doppelgangR(test_esets, phenoFinder.args = NULL)

# Enable "Smoking Gun" checks for specific columns
results <- doppelgangR(test_esets, manual.smokingguns = c("patient_id", "subject_uuid"))
```

### 3. Inspecting Results
The package provides `summary`, `print`, and `plot` methods for the resulting `DoppelGang` object.

```r
# View a summary of identified duplicates
summary(results)

# Visualize correlation distributions
# Red vertical lines indicate flagged outliers
par(mfrow=c(2,2))
plot(results)

# Plot a specific pair of datasets
plot(results, plot.pair = c("StudyA", "StudyB"))
```

## Advanced Options

### Adjusting Sensitivity
If the default threshold (Bonferroni probability of 0.5) is too strict or too lenient, adjust the `outlierFinder.expr.args`. Increasing `bonf.prob` increases sensitivity.

```r
results <- doppelgangR(test_esets,
    outlierFinder.expr.args = list(bonf.prob = 1.0, transFun = atanh, tail = "upper"))
```

### Parallel Processing
For large collections of datasets, use `BiocParallel` to speed up pairwise comparisons.

```r
library(BiocParallel)
results <- doppelgangR(test_esets, BPPARAM = MulticoreParam(workers = 4))
```

### Caching
`doppelgangR` caches intermediate results by default. To disable this or change the directory:

```r
# Disable caching
results <- doppelgangR(test_esets, cache.dir = NULL)
```

## Tips for Success
- **RNA-seq Data**: Ensure RNA-seq data is **log-transformed** before running `doppelgangR`.
- **Phenotype Matching**: To use phenotype checking effectively, ensure column names (e.g., "age", "gender") and encoding are identical across all `ExpressionSet` objects in the list.
- **Batch Effects**: The package uses `ComBat` by default within the expression check to handle platform differences. This can be customized via `corFinder.args`.

## Reference documentation
- [doppelgangR](./references/doppelgangR.md)