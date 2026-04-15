---
name: bioconductor-ecolileucine
description: This package provides access to the ecoliLeucine Bioconductor experiment data package containing Affymetrix microarray data for E. coli. Use when user asks to load the Hung et al. (2002) Lrp dataset, analyze E. coli microarray experiments, or perform normalization and differential expression on AffyBatch objects.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ecoliLeucine.html
---

# bioconductor-ecolileucine

name: bioconductor-ecolileucine
description: Access and use the ecoliLeucine Bioconductor experiment data package. Use this skill when a user needs to load, analyze, or explore the Affymetrix E. coli microarray data from the Hung et al. (2002) study regarding the Leucine-responsive regulatory protein (Lrp).

# bioconductor-ecolileucine

## Overview
The `ecoliLeucine` package is a Bioconductor data experiment package containing an `AffyBatch` object. This dataset represents a study of the Leucine-responsive regulatory protein (Lrp) in *Escherichia coli*. The data consists of 8 Affymetrix chips comparing two strains: 4 samples of lrp+ (wild-type) and 4 samples of lrp- (mutant). It is primarily used for demonstrating microarray analysis workflows, including normalization, differential expression, and quality control using the `affy` package.

## Loading the Data
To use the dataset, you must load the library and the specific data object.

```r
# Load the package
library(ecoliLeucine)

# Load the AffyBatch object
data(ecoliLeucine)

# Inspect the object
ecoliLeucine
```

## Typical Workflow

### 1. Data Inspection
Since the data is stored as an `AffyBatch` object, you can use standard `affy` methods to inspect it:

```r
# View sample names
sampleNames(ecoliLeucine)

# View phenoData (experimental design)
pData(ecoliLeucine)

# Check the CDF environment (requires ecolicdf package)
getCdfInfo(ecoliLeucine)
```

### 2. Quality Control
Visualize the raw data to check for artifacts or distribution differences:

```r
# Plot log-intensities (boxplot)
boxplot(ecoliLeucine, col = c(rep("blue", 4), rep("red", 4)))

# Density plot
hist(ecoliLeucine)
```

### 3. Pre-processing (Normalization)
Convert the raw `AffyBatch` into an `ExpressionSet` using Robust Multi-array Average (RMA) or other algorithms:

```r
library(affy)

# RMA normalization
eset <- rma(ecoliLeucine)

# Get the expression matrix
exp_matrix <- exprs(eset)
```

### 4. Differential Expression
The dataset is designed to compare lrp+ vs lrp-. You can define the groups based on the sample order (first 4 are lrp+, last 4 are lrp-):

```r
# Example using a simple t-test or limma
groups <- factor(c(rep("lrp_plus", 4), rep("lrp_minus", 4)))
# Proceed with standard Bioconductor differential expression analysis
```

## Tips
- **Dependencies**: This package requires the `affy` package for data manipulation and the `ecolicdf` package to map probe intensities to gene identifiers.
- **Data Source**: The data originates from the CyberT website and relates to the study by Hung et al. (2002) in the Journal of Biological Chemistry.
- **Object Class**: The main object `ecoliLeucine` is of class `AffyBatch`. If you need to use modern `SummarizedExperiment` workflows, you may need to coerce the object or use `makeSummarizedExperimentFromExpressionSet` after pre-processing.

## Reference documentation
- [ecoliLeucine Reference Manual](./references/reference_manual.md)