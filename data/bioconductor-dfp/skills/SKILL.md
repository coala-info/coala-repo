---
name: bioconductor-dfp
description: This tool performs gene selection and data reduction on microarray data using the Discriminant Fuzzy Pattern algorithm. Use when user asks to identify differentially expressed genes, discretize expression values into linguistic labels, or extract genes that discriminate between experimental classes.
homepage: https://bioconductor.org/packages/release/bioc/html/DFP.html
---

# bioconductor-dfp

name: bioconductor-dfp
description: Perform gene selection and data reduction on microarray data using the Discriminant Fuzzy Pattern (DFP) algorithm. Use this skill to identify differentially expressed genes by converting continuous expression values into linguistic labels (Low, Medium, High) and extracting genes that discriminate between experimental classes.

## Overview

The DFP package implements a supervised fuzzy pattern algorithm designed to filter genes in DNA microarray data. It addresses the high-dimensionality problem (many genes, few samples) by identifying genes that exhibit consistent expression patterns within a class but different patterns across classes. The algorithm discretizes expression values into linguistic labels and calculates a "Discriminant Fuzzy Pattern" (DFP) to provide a short list of biologically significant genes.

## Core Workflow

### Quick Start

Use the wrapper function to execute the entire pipeline with default parameters on an `ExpressionSet` object.

```r
library(DFP)
data(rmadataset) # Example dataset
res <- discriminantFuzzyPattern(rmadataset)

# Visualize results
plotDiscriminantFuzzyPattern(res$discriminant.fuzzy.pattern)
```

### Step-by-Step Execution

For finer control, execute the algorithm in four distinct steps:

1.  **Calculate Membership Functions**: Determine the centers and widths for 'Low', 'Medium', and 'High' expression levels.
    ```r
    mfs <- calculateMembershipFunctions(rmadataset, skipFactor = 3)
    plotMembershipFunctions(rmadataset, mfs, featureNames(rmadataset)[1:2])
    ```

2.  **Discretize Expression Values**: Convert float expression values into linguistic labels based on a threshold (`zeta`).
    ```r
    dvs <- discretizeExpressionValues(rmadataset, mfs, zeta = 0.5, overlapping = 2)
    ```

3.  **Calculate Fuzzy Patterns**: Identify the representative label for each gene within each class. A gene must meet the `piVal` frequency threshold to be assigned a label.
    ```r
    fps <- calculateFuzzyPatterns(rmadataset, dvs, piVal = 0.9, overlapping = 2)
    ```

4.  **Calculate Discriminant Fuzzy Patterns**: Extract genes that appear in at least two different Fuzzy Patterns with different linguistic labels.
    ```r
    dfps <- calculateDiscriminantFuzzyPattern(rmadataset, fps)
    ```

## Parameter Tuning

Adjust these parameters to refine the gene selection sensitivity:

*   `skipFactor`: (Default: 3) Controls outlier handling. Higher values consider fewer samples as "odd" or outliers.
*   `zeta`: (Default: 0.5) Threshold for activating a linguistic label. Range [0, 1].
*   `piVal`: (Default: 0.9) The percentage of samples in a class that must share a label for it to be included in the pattern. Higher values result in fewer, more stringent gene selections.
*   `overlapping`: Determines label granularity:
    *   `1`: 3 labels (Low, Medium, High).
    *   `2`: 5 labels (adds Low-Medium and Medium-High).
    *   `3`: 6 labels (adds Low-Medium-High).

## Data Input

The package primarily works with `ExpressionSet` objects. To load custom CSV data:

```r
# fileExprs: CSV with gene expression (genes in rows, samples in columns)
# filePhenodata: CSV with sample metadata (must include a 'class' column)
rmadataset <- readCSV(fileExprs, filePhenodata)
```

## Interpreting Results

*   **Impact Factor (ifs)**: A value returned in the attributes of the DFP result. It indicates the strength of a gene's membership in a class pattern.
*   **NA values**: In the DFP matrix, `NA` indicates that the gene's impact factor did not meet the `piVal` threshold for that specific class.
*   **Visualization Colors**:
    *   **Blue**: 'Low' expression.
    *   **Green**: 'Medium' expression.
    *   **Red**: 'High' expression.

## Reference documentation

- [DFP](./references/DFP.md)