---
name: bioconductor-serumstimulation
description: This package provides a processed microarray dataset tracking the transcriptomic response to serum stimulation in thirteen samples. Use when user asks to access example gene expression data, perform principal component analysis on serum stimulation samples, or conduct functional analysis using the pcaGoPromoter package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/serumStimulation.html
---

# bioconductor-serumstimulation

name: bioconductor-serumstimulation
description: Access and utilize the serumStimulation microarray dataset from Bioconductor. Use this skill when a user needs example gene expression data from a serum stimulation experiment, specifically for demonstrating PCA, functional analysis, or as a dependency for the pcaGoPromoter package.

## Overview
The `serumStimulation` package is a Bioconductor Experiment Data package. It provides a processed dataset derived from a DNA microarray analysis of 13 samples. The experiment tracks the transcriptomic response to serum stimulation, including controls and samples treated with or without inhibitors.

The data has been pre-processed from raw .CEL files using the `ReadAffy` function and normalized via the Robust Multi-array Average (RMA) algorithm.

## Data Structure
The dataset consists of a single object: `serumStimulation`.
- **Type**: Matrix (the output of `exprs()`).
- **Samples**: 13 total.
  - 5 Controls.
  - 5 Serum stimulated with inhibitor.
  - 3 Serum stimulated without inhibitor.
- **Features**: Expression values for probesets.

## Using the Package in R

### Loading the Data
To use the dataset, load the library and call the `data()` function:

```r
# Load the package
library(serumStimulation)

# Load the dataset into the R environment
data(serumStimulation)

# View the dimensions of the expression matrix
dim(serumStimulation)

# View the first few rows and columns
serumStimulation[1:5, 1:5]
```

### Typical Workflow
This data is frequently used to demonstrate principal component analysis (PCA) or gene ontology (GO) term enrichment.

1. **Inspection**: Check column names to identify sample groups.
   ```r
   colnames(serumStimulation)
   ```

2. **Downstream Analysis**: Use the matrix as input for packages like `pcaGoPromoter`.
   ```r
   # Example: Using with pcaGoPromoter (if installed)
   # library(pcaGoPromoter)
   # pca_results <- pca(serumStimulation)
   ```

3. **Differential Expression**: Since the data is already RMA-normalized (log2 scale), it is ready for linear modeling (e.g., using `limma`) or visualization (e.g., heatmaps).

## Tips
- The object `serumStimulation` is a standard R matrix of expression values, not an `ExpressionSet` object. If an `ExpressionSet` is required by a specific tool, you may need to wrap it using `Biobase::ExpressionSet(assayData = serumStimulation)`.
- Ensure Bioconductor is initialized via `BiocManager::install("serumStimulation")` if the package is missing from the environment.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)