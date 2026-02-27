---
name: bioconductor-mdqc
description: This tool performs multivariate quality control for high-throughput data by identifying outlier samples using Mahalanobis Distances. Use when user asks to identify low-quality microarrays, detect outliers in quality control reports, or compute robust Mahalanobis Distances for sample assessment.
homepage: https://bioconductor.org/packages/release/bioc/html/mdqc.html
---


# bioconductor-mdqc

name: bioconductor-mdqc
description: Multivariate Quality Control (MDQC) for microarrays and other high-throughput data. Use this skill to identify low-quality arrays or samples by computing Mahalanobis Distances on quality control (QC) reports. It is particularly useful for detecting outliers while accounting for the correlation structure of quality measures and using robust estimators to prevent masking effects.

## Overview

The `mdqc` package implements Mahalanobis Distance Quality Control, a multivariate method for assessing the quality of microarrays. It treats quality assessment as an outlier detection problem. By calculating the Mahalanobis Distance (MD) of an array's quality attributes relative to the rest of the dataset, it identifies samples that deviate significantly from the norm. The package supports robust estimators (like S-estimators or MCD) to ensure that outliers themselves do not bias the "normal" baseline.

## Core Workflow

The typical workflow involves taking a data frame or matrix of QC measures (where rows are arrays/samples and columns are quality metrics) and applying the `mdqc` function.

1.  **Load the package and data**:
    ```r
    library(mdqc)
    data(allQC) # Example QC report
    ```

2.  **Run MDQC**:
    Choose a method based on the number of variables and desired granularity.
    ```r
    # Basic approach: Use all variables (requires n > p)
    mdout <- mdqc(allQC, method="nogroups")
    ```

3.  **Examine Results**:
    ```r
    summary(mdout)
    plot(mdout)
    print(mdout) # Lists arrays exceeding 90%, 95%, and 99% Chi-Square thresholds
    ```

## Analysis Methods

MDQC provides five primary methods to handle different data structures and dimensionality:

### 1. No Groups (`method="nogroups"`)
Computes a single MD using all quality measures. Only applicable if the number of arrays ($n$) is greater than the number of measures ($p$).

### 2. A Priori Grouping (`method="apriori"`)
The user manually groups variables based on biological or technical interpretation (e.g., grouping scale factors together, and degradation measures together).
```r
# Group 1: cols 1-5; Group 2: cols 6-9; Group 3: cols 10-11
mdout <- mdqc(allQC, method="apriori", groups=list(1:5, 6:9, 10:11))
```

### 3. Cluster Grouping (`method="cluster"`)
Data-driven grouping using the Partitioning Around Medoids (PAM) algorithm based on a robust correlation matrix.
```r
mdout <- mdqc(allQC, method="cluster", k=3)
```

### 4. Loading PCA Grouping (`method="loading"`)
Groups variables based on their contributions (loadings) to the first $k$ principal components of a robust PCA.
```r
mdout <- mdqc(allQC, method="loading", k=3, pc=4)
```

### 5. Global PCA (`method="global"`)
Reduces the entire QC report to the first $k$ principal components and computes a single MD in that reduced space. Useful when $p$ is large.
```r
mdout <- mdqc(allQC, method="global", pc=4)
```

## Key Functions

- `mdqc(x, method, ...)`: Main function. `x` is the QC data.
- `prcomp.robust(x, ...)`: Performs robust Principal Component Analysis.
- `plot.mdqc(x)`: Generates diagnostic plots showing MDs relative to Chi-Square distribution cutoffs.

## Tips for Success

- **Dimensionality**: MDQC requires $n \ge p$ for any specific group. If you have many quality measures but few arrays, use the `apriori`, `cluster`, or `loading` methods to split variables into smaller sets.
- **Robustness**: The default uses S-estimators. If the dataset is very small, robust estimators may be unstable; ensure you have a sufficient number of arrays for the chosen breakdown point.
- **Interpretation**: If an array is flagged in an "A Priori" group related to "Preparation," the quality issue likely stems from sample handling rather than chip defects.

## Reference documentation

- [MDQC: Mahalanobis Distance Quality Control](./references/mdqcvignette.md)