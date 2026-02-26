---
name: bioconductor-gpaexample
description: This package provides example GWAS p-value and functional annotation data from the Psychiatric GWAS Consortium for use with the GPA package. Use when user asks to access sample datasets for multi-phenotype genetic analysis, test pleiotropy estimation models, or practice integrating functional annotations with GWAS results.
homepage: https://bioconductor.org/packages/release/data/experiment/html/gpaExample.html
---


# bioconductor-gpaexample

name: bioconductor-gpaexample
description: Provides example GWAS p-value and annotation data for the GPA (Genetic analysis incorporating Pleiotropy and Annotation) package. Use this skill when a user needs to demonstrate, test, or practice multi-phenotype genetic analysis, pleiotropy estimation, or functional annotation integration using the PGC psychiatric disorder dataset.

# bioconductor-gpaexample

## Overview

The `gpaExample` package is a specialized data experiment package for Bioconductor. It provides a high-quality, real-world dataset consisting of p-values from five psychiatric disorder Genome-Wide Association Studies (GWAS) conducted by the Psychiatric GWAS Consortium (PGC). It also includes binary annotation data related to the central nervous system (CNS). This package is primarily intended to be used as the input for the `GPA` package to perform statistical integration of multiple GWAS traits.

## Data Structure

The package contains a single primary object: `exampleData`.

- **Type**: A list containing two matrices.
- **`exampleData$pval`**: A matrix of size 1,219,805 x 5.
    - Columns represent: ADHD, ASD, BPD, MDD, and SCZ.
    - Values are p-values for 1,219,805 SNPs.
- **`exampleData$ann`**: A matrix of size 1,219,805 x 1.
    - Binary indicators (1 or 0) for SNPs within 50-kb of genes preferentially expressed in the Central Nervous System (CNS).

## Usage Workflow

### Loading the Data

To use the example data in an R session:

```R
# Load the package
library(gpaExample)

# Load the dataset into the workspace
data(exampleData)

# Inspect the structure
str(exampleData)

# View the first few rows of p-values
head(exampleData$pval)

# View the first few rows of annotation data
head(exampleData$ann)
```

### Integration with the GPA Package

The typical use case for this data is to provide it as input to the `GPA` function from the `GPA` package to identify risk loci and estimate pleiotropy.

```R
# Assuming the GPA package is installed
library(GPA)

# Fit a GPA model using the example p-values and CNS annotation
# Note: This is a computationally intensive step
fit <- GPA(exampleData$pval, exampleData$ann)

# Summarize results
print(fit)
```

## Tips

- **SNP Alignment**: The rows in `exampleData$pval` and `exampleData$ann` are perfectly aligned by SNP. If you subset one, ensure you subset the other using the same indices.
- **Memory Management**: The p-value matrix is large (over 1.2 million rows). Ensure the R environment has sufficient memory when performing operations on the full dataset.
- **Missing Values**: The dataset is pre-processed for use with the GPA algorithm; however, always check for `NA` values if performing custom statistical tests.

## Reference documentation

- [gpaExample Reference Manual](./references/reference_manual.md)