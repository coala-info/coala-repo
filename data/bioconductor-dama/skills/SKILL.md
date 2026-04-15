---
name: bioconductor-dama
description: This package facilitates the design and statistical analysis of factorial two-colour microarray experiments. Use when user asks to evaluate experimental design efficiency, construct contrast matrices, or perform spot-wise t-tests and F-tests on microarray data.
homepage: https://bioconductor.org/packages/release/bioc/html/daMA.html
---

# bioconductor-dama

name: bioconductor-dama
description: Efficient design and analysis of factorial two-colour microarray experiments. Use this skill when designing microarray experiments or performing statistical analysis on factorial microarray data using the daMA package. It supports calculating design efficiencies (D, E, or T optimality), constructing contrast matrices, and performing spot-wise t-tests or F-tests with multiplicity adjustments.

## Overview

The `daMA` package is specialized for two-colour (dual-channel) microarray experiments with factorial designs. It provides tools for two primary phases:
1.  **Experimental Design**: Evaluating the efficiency of different array allocation strategies (e.g., loops, swaps, common reference) using optimality criteria.
2.  **Statistical Analysis**: Analyzing normalized microarray data using linear models to test specific experimental questions (contrasts), such as main effects or interactions.

## Core Workflow

### 1. Experimental Design with `designMA`

Before conducting an experiment, use `designMA` to compare potential designs.

```r
library(daMA)

# Load example designs or provide a custom list
data(designs.composite)

# Define the contrast matrix (cmat) and grouping (cinfo)
# cinfo: 1 for vectorial contrast, n > 1 for matrix contrast (e.g., interaction)
data(cmatB.AB)
data(cinfoB.AB)

# Compute efficiencies using the Trace criterion ("t")
# Other options: "d" (determinant), "e" (eigenvalue)
efficiency_results <- designMA(design.list = designs.composite, 
                               cmat = cmatB.AB, 
                               cinfo = cinfoB.AB, 
                               type = "t")

# Identify the best design
best_design_name <- efficiency_results$effdesign
```

### 2. Statistical Analysis with `analyseMA`

Once data is collected and normalized, use `analyseMA` to perform spot-wise testing.

```r
# data: G x N matrix (G spots, N arrays)
# design: N x (K+2) matrix (first two columns for dyes, usually 1 and -1)
# id: Vector of spot identifiers
# padj: "none", "bonferroni", or "fdr"

results <- analyseMA(data = data.3x2, 
                     design = designs.composite$BSBSBS, 
                     id = id.3x2, 
                     cmat = cmatB.AB, 
                     cinfo = cinfoB.AB, 
                     padj = "fdr")
```

### 3. Interpreting Results

The output of `analyseMA` is a matrix of size $G \times (4p + 3)$, where $p$ is the number of experimental questions:
*   **Column 1**: Spot ID.
*   **Columns 2 to p+1**: Estimates (for vectors) or Numerator DF (for F-tests).
*   **Columns p+2 to 2p+1**: Test statistics (t or F).
*   **Columns 2p+2 to 3p+1**: Raw P-values.
*   **Columns 3p+2 to 3p+3**: MSE and Residual DF.
*   **Columns 3p+4 to 4p+3**: Adjusted P-values.

## Key Data Structures

*   **Design Matrix**: Rows are arrays, columns are parameters. The first two columns represent the dyes (Green/Red).
*   **Contrast Matrix (`cmat`)**: Defines the comparisons. For example, to compare dyes directly, use `(-1, 1, 0, ...)`.
*   **Contrast Info (`cinfo`)**: A vector that tells the package how to group rows in `cmat`. If `cmat` has 4 rows where the first 2 are individual contrasts and the last 2 represent a single interaction effect, `cinfo` would be `c(1, 1, 2)`.

## Tips for Success

*   **Missing Values**: `analyseMA` handles `NA` values by dropping the affected arrays for that specific spot calculation.
*   **Estimability**: The package automatically checks if a contrast is estimable for a given design. If not, it returns `NA` for that effect.
*   **Normalization**: Data must be normalized and/or standardized *before* using `analyseMA`.

## Reference documentation

- [daMA Reference Manual](./references/reference_manual.md)