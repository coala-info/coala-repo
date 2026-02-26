---
name: r-dinamic.duo
description: The DiNAMIC.Duo package detects and compares recurrent DNA copy number alterations between two distinct cohorts using cyclic shift permutations. Use when user asks to identify differences in recurrence patterns between groups, find subtype-specific genomic drivers, or detect recurrent copy number changes in a single cohort.
homepage: https://cran.r-project.org/web/packages/dinamic.duo/index.html
---


# r-dinamic.duo

## Overview
The `DiNAMIC.Duo` package provides tools to detect recurrent DNA copy number changes. While many tools identify alterations within a single group, `DiNAMIC.Duo` is specifically designed to identify differences in recurrence patterns between two distinct cohorts (e.g., comparing two different cancer subtypes). It utilizes cyclic shift permutations to maintain the underlying genomic structure while assessing statistical significance.

## Installation
To install the package from CRAN:
```R
install.packages("DiNAMIC.Duo")
```
Note: This package requires Python and the NumPy library to be installed on the system for certain computational tasks.

## Core Workflow

### 1. Data Preparation
The package typically requires a matrix of copy number values where rows represent genomic markers (probes/bins) and columns represent individual samples. A common set of genomic markers must be used for both cohorts when performing comparative analysis.

### 2. Single Cohort Analysis
To find recurrent alterations in one group:
- Use `recurrent.copy.number()` to identify regions of significant gain or loss.
- This builds upon the original `DiNAMIC` methodology.

### 3. Two-Cohort Comparison
The primary strength of the package is comparing two groups:
- Use `recurrent.copy.number.comparison()` to find regions where the frequency or magnitude of CNAs differs significantly between Group A and Group B.
- This is useful for identifying subtype-specific genomic drivers.

### 4. Downstream Analysis and Visualization
- **Summary Files**: Generate detailed tables of significant genomic regions.
- **Graphics**: Create plots to visualize the landscape of copy number differences across the genome.
- **Annotation**: The package integrates with `biomaRt` to help annotate identified regions with gene symbols and genomic coordinates.

## Key Functions
- `recurrent.copy.number`: Identifies recurrent CNAs in a single cohort.
- `recurrent.copy.number.comparison`: Identifies differences in recurrent CNAs between two cohorts.
- `get.gene.info`: (Internal/Helper) Leverages `biomaRt` to fetch gene-level information for significant regions.

## Tips for Success
- **Permutations**: The reliability of the p-values depends on the number of cyclic shift permutations. For publication-quality results, ensure a sufficient number of shifts are performed.
- **Marker Alignment**: Ensure that the genomic markers (rows) are identical and in the same order when comparing two datasets.
- **Python Dependency**: If you encounter errors related to computation, verify that `reticulate` can find a valid Python installation with `NumPy`.

## Reference documentation
- [DiNAMIC.Duo Home Page](./references/home_page.md)
- [DiNAMIC.Duo README](./references/README.html.md)