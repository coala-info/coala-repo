---
name: r-seamless
description: R package seamless (documentation from project home).
homepage: https://cran.r-project.org/web/packages/seamless/index.html
---

# r-seamless

name: r-seamless
description: Deconvolution of bulk Acute Myeloid Leukemia (AML) RNA-seq samples using a healthy single-cell reference atlas. Use this skill when you need to estimate cell-type proportions in AML samples, predict Venetoclax resistance, or visualize AML composition using ternary plots.

## Overview

The `seAMLess` package provides a pipeline for deconvoluting bulk RNA-seq data from Acute Myeloid Leukemia (AML) patients. It utilizes a healthy single-cell reference atlas to identify cell-type proportions (e.g., CD14 Mono, GMP, T Cells) and includes a predictive model for Venetoclax resistance based on the transcriptomic profile.

## Installation

To use this skill, ensure the package and its required data component are installed:

```R
# Install from CRAN
install.packages("seAMLess")

# Install the required data package (essential for the deconvolution reference)
install.packages("seAMLessData", repos = "https://eonurk.github.io/drat/")

# Load the library
library(seAMLess)
library(xbioc) # Required dependency for deconvolution logic
```

## Workflow

### 1. Prepare Input Data
The input should be a data frame or matrix of bulk RNA-seq counts. Rows should be gene identifiers (Ensembl IDs or Gene Symbols) and columns should be samples.

```R
data(exampleTCGA)
# View the first few rows and columns
head(exampleTCGA)[, 1:4]
```

### 2. Run Deconvolution
The `seAMLess()` function performs gene ID conversion (if necessary), deconvolutes the samples, and predicts Venetoclax resistance.

```R
res <- seAMLess(exampleTCGA)

# Access cell type proportions
head(res$Deconvolution)

# Access Venetoclax resistance scores
res$Venetoclax.resistance
```

### 3. Visualization
Use the built-in plotting function to visualize the distribution of cell types across samples.

```R
# Create a ternary plot of the results
ternaryPlot(res)
```

## Tips
- **Gene IDs**: The package automatically handles the conversion of Human Ensembl IDs to Gene Symbols.
- **Dependencies**: Ensure `xbioc` is loaded alongside `seAMLess` to avoid execution errors during the deconvolution step.
- **Data Package**: The `seAMLessData` package is large as it contains the single-cell reference atlas; ensure a stable internet connection during its installation.

## Reference documentation
- [README.Rmd](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [Articles](./references/articles.md)
- [Figures](./references/figure-gfm.md)
- [Home Page](./references/home_page.md)