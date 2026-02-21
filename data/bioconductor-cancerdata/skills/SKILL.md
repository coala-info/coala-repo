---
name: bioconductor-cancerdata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/cancerdata.html
---

# bioconductor-cancerdata

name: bioconductor-cancerdata
description: Access and use breast cancer gene expression datasets from the Bioconductor 'cancerdata' package. Use this skill when a user needs to load, explore, or analyze high-dimensional molecular data from the van't Veer (VEER) or Vijver (VIJVER) studies, typically for developing or validating diagnostic tests and cancer outcome predictions.

## Overview
The `cancerdata` package is a data-only experiment package for Bioconductor. It provides high-dimensional gene expression datasets specifically curated for use with the `cancerclass` package, though they are compatible with any Biobase-based analysis. The data originates from landmark breast cancer studies and is provided in both raw and filtered formats as `ExpressionSet` objects.

## Loading the Package and Data
To use these datasets, you must first load the library and then use the `data()` function to load specific objects into your R environment.

```r
# Load the package
library(cancerdata)

# Load the van't Veer datasets
data(VEER)   # 24,481 genes, 78 samples
data(VEER1)  # Filtered: 4,948 genes, 78 samples

# Load the Vijver datasets
data(VIJVER)  # 24,481 genes, 295 samples
data(VIJVER1) # Filtered: 4,948 genes, 295 samples

# Load the van't Veer young patients datasets
data(YOUNG)   # 24,481 genes, 19 samples
data(YOUNG1)  # Filtered: 4,948 genes, 19 samples
```

## Working with the Data
All datasets are stored as `ExpressionSet` objects. You can interact with them using standard `Biobase` methods:

### Exploring Metadata
Use `pData()` to see clinical information and sample annotations.
```r
# View sample information
pheno <- pData(VEER1)
head(pheno)

# Check sample size and feature count
dim(VEER1)
```

### Accessing Expression Values
Use `exprs()` to extract the gene expression matrix.
```r
# Get expression matrix
exp_matrix <- exprs(VEER1)

# Summary of expression values
summary(exp_matrix[, 1:5])
```

### Feature Information
Use `fData()` or `featureNames()` to inspect the genes/probes included.
```r
# Get gene identifiers
genes <- featureNames(VEER1)
head(genes)
```

## Typical Workflow
1. **Selection**: Choose between the full dataset (e.g., `VEER`) for discovery or the filtered version (e.g., `VEER1`) for validated diagnostic test development.
2. **Preprocessing**: Since these are `ExpressionSet` objects, they are ready for differential expression analysis (e.g., using `limma`) or classification tasks.
3. **Integration**: These datasets are specifically designed to be passed into functions from the `cancerclass` package for calculating clinical outcome predictors.

## Tips
- The "1" suffix (e.g., `VEER1`, `VIJVER1`) denotes a filtered version of the original dataset containing approximately 5,000 genes, which is often more computationally efficient for testing classification algorithms.
- The `YOUNG` dataset is a subset of the van't Veer study focusing specifically on young patients.

## Reference documentation
- [cancerdata Reference Manual](./references/reference_manual.md)