---
name: bioconductor-biobase
description: This package provides standardized data structures and functions for managing high-throughput genomic data in R. Use when user asks to create ExpressionSet objects, access sample or feature metadata, subset genomic datasets, or apply functions across features using esApply.
homepage: https://bioconductor.org/packages/release/bioc/html/Biobase.html
---


# bioconductor-biobase

name: bioconductor-biobase
description: Use this skill when working with the Bioconductor Biobase package in R. It provides guidance on managing high-throughput genomic data using the eSet and ExpressionSet class hierarchy, including data construction, subsetting, and applying functions across features.

# bioconductor-biobase

## Overview
Biobase is a fundamental Bioconductor package that provides standardized data structures for representing genomic data. Its primary contribution is the `ExpressionSet` class, which coordinates expression data (assay data), sample metadata (phenoData), feature metadata (featureData), and experiment descriptions (MIAME) into a single, synchronized object. This ensures that subsetting or manipulating the data maintains the correct associations between genes and samples.

## Core Workflows

### 1. Creating an ExpressionSet from Scratch
To build an `ExpressionSet`, you typically need a matrix of expression values and an `AnnotatedDataFrame` for sample metadata.

```r
library(Biobase)

# 1. Prepare Assay Data (Matrix: Rows=Features, Cols=Samples)
exprs_matrix <- matrix(runif(1000), nrow=100, ncol=10)
colnames(exprs_matrix) <- LETTERS[1:10]
rownames(exprs_matrix) <- paste0("gene", 1:100)

# 2. Prepare Phenotypic Data (AnnotatedDataFrame)
p_data <- data.frame(gender=rep(c("Male", "Female"), 5),
                     row.names=colnames(exprs_matrix))
metadata <- data.frame(labelDescription=c("Patient gender"),
                       row.names=c("gender"))
pheno_data <- new("AnnotatedDataFrame", data=p_data, varMetadata=metadata)

# 3. Assemble the ExpressionSet
example_set <- ExpressionSet(assayData=exprs_matrix,
                             phenoData=pheno_data,
                             annotation="hgu95av2")
```

### 2. Accessing and Manipulating Data
Biobase provides specific accessor functions to interact with `ExpressionSet` components.

*   **Expression Matrix:** `exprs(obj)`
*   **Sample Metadata:** `pData(obj)` or `obj$column_name`
*   **Feature Names:** `featureNames(obj)`
*   **Sample Names:** `sampleNames(obj)`
*   **Subsetting:** `obj[features, samples]` (e.g., `obj[1:10, 1:5]`)

### 3. Applying Functions with esApply
`esApply` is a specialized version of `apply` for `ExpressionSet` objects. It automatically makes `phenoData` variables available within the environment of the function being applied.

```r
# Function that uses 'gender' directly from phenoData
my_func <- function(y) {
    # 'gender' is available because it's a column in pData
    t.test(y ~ gender)$p.value
}

p_vals <- esApply(example_set, 1, my_func)
```

### 4. Object Versioning and Updates
If you encounter older Biobase objects (e.g., from saved .RData files), use `updateObject` to bring them to the current class definition.

```r
updated_obj <- updateObject(old_object)
isCurrent(updated_obj)
```

## Developer Tips
*   **Virtual Class:** `eSet` is a virtual class; you should generally instantiate `ExpressionSet` or create your own subclass.
*   **Storage Mode:** By default, `assayData` uses `lockedEnvironment` to prevent accidental side effects while remaining memory efficient. Use `storageMode(obj) <- "list"` if you need standard list behavior.
*   **Validity:** Use `validObject(obj)` after manual manipulations to ensure the dimensions and names of all slots still match.

## Reference documentation
- [Biobase development and the new eSet](./references/BiobaseDevelopment.md)
- [An Introduction to Bioconductor’s ExpressionSet Class](./references/ExpressionSetIntroduction.md)
- [esApply Introduction](./references/esApply.md)