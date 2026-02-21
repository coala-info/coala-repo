---
name: bioconductor-colonca
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/colonCA.html
---

# bioconductor-colonca

name: bioconductor-colonca
description: Access and analyze the Alon et al. (1999) colon cancer microarray dataset. Use this skill when a user needs to load the `colonCA` ExpressionSet, perform differential expression analysis between tumor and normal colon tissues, or practice microarray data handling using a classic Bioconductor experiment data package.

# bioconductor-colonca

## Overview
The `colonCA` package provides a classic high-dimensional dataset from a 1999 study by Alon et al. It contains gene expression measurements for 2000 genes across 62 samples (40 tumor, 22 normal) collected using Affymetrix Hum6000 arrays. The data is encapsulated in a Bioconductor `ExpressionSet` object, making it compatible with standard analysis workflows in the `Biobase` and `limma` ecosystems.

## Data Loading and Inspection
To use the dataset, you must load the library and the data object.

```r
# Load the package and data
library(colonCA)
data(colonCA)

# Inspect the ExpressionSet object
colonCA

# Access expression values (matrix of 2000 rows x 62 columns)
exp_matrix <- exprs(colonCA)

# Access phenotype data (sample metadata)
pheno_data <- pData(colonCA)
```

## Metadata and Covariates
The dataset includes three primary covariates in the phenotype data:
- `expNr`: The sample number.
- `samp`: Sample code (positive for Normal tissue, negative for Tumor tissue).
- `class`: Tissue identity (`n` for Normal, `t` for Tumor).

```r
# Check the distribution of samples
table(colonCA$class)

# Access specific metadata columns
sample_classes <- colonCA$class
```

## Common Workflows

### Basic Data Exploration
```r
# View the first few rows and columns of expression data
exprs(colonCA)[1:5, 1:5]

# Check feature (gene) names
# Note: featureNames were made unique using make.names(unique=TRUE)
featureNames(colonCA)[1:20]
```

### Differential Expression Setup
Because the data is an `ExpressionSet`, it is ready for use with `limma` for differential expression analysis.

```r
library(limma)

# Create design matrix based on tissue class
design <- model.matrix(~ colonCA$class)

# Fit linear model
fit <- lmFit(colonCA, design)
fit <- eBayes(fit)

# View top differentially expressed genes
topTable(fit)
```

## Usage Tips
- **Preprocessing**: The 2000 genes were pre-selected by the original authors based on confidence levels. No further normalization was applied to the data in this package; users may want to consider log-transformation or normalization depending on their specific analysis goals.
- **Feature Names**: Be aware that some `featureNames` have suffixes like `.1` or `.2` to ensure uniqueness, as the original submission contained duplicate identifiers.
- **Compatibility**: This package depends on `Biobase`. Ensure `Biobase` is loaded to use methods like `exprs()`, `pData()`, and `featureNames()`.

## Reference documentation
- [colonCA Reference Manual](./references/reference_manual.md)