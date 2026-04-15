---
name: bioconductor-cafe
description: CAFE identifies chromosomal gains and losses by analyzing Affymetrix microarray expression data. Use when user asks to detect chromosomal aberrations, perform virtual karyotyping, or visualize gene expression deviations across chromosomes and cytobands.
homepage: https://bioconductor.org/packages/release/bioc/html/CAFE.html
---

# bioconductor-cafe

name: bioconductor-cafe
description: Chromosomal Aberrations Finder in Expression data (CAFE). Use this skill to analyze Affymetrix microarray expression data to detect gross chromosomal gains or losses (virtual karyotyping) and visualize aberrations using ggplot2-based plotting functions.

# bioconductor-cafe

## Overview
CAFE (Chromosomal Aberrations Finder in Expression data) is an R package designed to identify chromosomal aberrations (gains and losses) by analyzing microarray expression profiles. It implements the approach of Ben-David et al. to detect significant deviations in gene expression across specific chromosomes or cytobands.

## Core Workflow

### 1. Data Preparation and Processing
CAFE primarily works with Affymetrix `.CEL` files. Place all CEL files in your working directory before starting.

```r
library(CAFE)

# Process CEL files in the current directory
# threshold.over: relative expression factor for overexpression (default 1.5)
# threshold.under: relative expression factor for underexpressed (default 0.5)
# remove_method: 0 (none), 1 (keep one probe per gene), 2 (keep one probe per location)
datalist <- ProcessCels(threshold.over=1.5, threshold.under=0.5, remove_method=1)

# For testing/reproducibility, you can load the built-in dataset
data("CAFE_data")
```

### 2. Statistical Analysis
Identify which chromosomes or bands are significantly over- or underexpressed compared to the rest of the dataset.

```r
# Identify samples by index
names(CAFE_data[[2]]) 
sam <- c(1, 3) # Indices of samples to test

# Test a specific chromosome (e.g., Chromosome 17)
# test: "fisher" (exact) or "chisqr" (approximation)
# enrichment: "greater" (gains) or "less" (losses)
chromosomeStats(CAFE_data, chromNum=17, samples=sam, test="fisher", bonferroni=FALSE, enrichment="greater")

# Test all chromosomes with Bonferroni correction
chromosomeStats(CAFE_data, chromNum="ALL", samples=sam, test="fisher", bonferroni=TRUE, enrichment="greater")

# Test specific chromosome bands for finer mapping
bandStats(CAFE_data, chromNum=17, samples=sam, test="fisher", bonferroni=TRUE, enrichment="greater")
```

### 3. Visualization
CAFE provides several ways to visualize expression levels across chromosomes.

*   **Raw Plot**: Individual probe log2 relative expression.
    ```r
    p1 <- rawPlot(CAFE_data, samples=c(1, 3), chromNum=17)
    ```
*   **Sliding Plot**: Applies a sliding average to smooth variation.
    ```r
    # k: window size for sliding average
    p2 <- slidPlot(CAFE_data, samples=c(1, 3), chromNum=17, k=100, combine=TRUE)
    ```
*   **Discontinuous Plot**: Uses a Potts filter to show distinct "jumps" in copy number.
    ```r
    # gamma: smoothness parameter (higher = fewer jumps)
    p3 <- discontPlot(CAFE_data, samples=c(1, 3), chromNum=17, gamma=100)
    ```
*   **Facet Plot**: View all chromosomes in a single horizontal plot.
    ```r
    p4 <- facetPlot(CAFE_data, samples=c(1, 3), slid=TRUE, k=100)
    ```

## Tips and Best Practices
*   **Non-Affymetrix Data**: While designed for CEL files, you can manually construct the `datalist` object. It must be a list containing three lists (`$whole`, `$over`, `$under`), each containing data frames with columns: `ID`, `Sym`, `Value`, `LogRel`, `Loc`, `Chr`, `Band`, and `Arm`.
*   **Fisher vs. Chi-Square**: Use `test="fisher"` for exact p-values. Use `test="chisqr"` for faster processing on very large datasets where an approximation is sufficient.
*   **Multiple Testing**: Always set `bonferroni=TRUE` when testing multiple chromosomes or bands to control the Type I error rate.

## Reference documentation
- [CAFE Manual](./references/CAFE-manual.md)