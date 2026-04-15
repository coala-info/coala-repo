---
name: bioconductor-mbttest
description: This tool performs multiple beta t-tests to identify differentially expressed genes or isoforms in transcriptomic count data. Use when user asks to identify differentially expressed genes in small-sample RNA-Seq datasets, determine optimal thresholds via null simulations, or generate MA plots and heatmaps for differential expression analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/MBttest.html
---

# bioconductor-mbttest

name: bioconductor-mbttest
description: Perform multiple beta t-tests for differential expression analysis of transcriptomic count data (RNA-Seq, SAGE, tags). Use this skill to identify differentially expressed genes or isoforms between two conditions, especially when working with small sample sizes (e.g., ≤ 6 replicates per condition).

## Overview
The `MBttest` package implements a beta t-test method derived from Baggerly et al. (2003). It is specifically optimized for high work efficiency, power, and stability in small-sample transcriptomic datasets. It introduces a gene-specific variable $\rho$ (rho) to control for "fudge effects" common in small samples. The workflow involves a unique simulation step to determine an optimal threshold $\omega$ (omega) before analyzing real data.

## Core Workflow

### 1. Data Preparation
Data must be a matrix or data frame where the left columns contain annotation (ID, gene name, etc.) and the right columns contain raw counts for two conditions.
```R
library(MBttest)
data(jkttcell) # Example dataset
# Annotation: columns 1:7; Counts: columns 8:13
```

### 2. Determining Omega ($\omega$) via Simulation
Before analyzing real data, you must determine the threshold $\omega$ using null simulations.
1. **Simulate Null Data**: Generate 4–6 datasets where no true differential expression exists.
   ```R
   # nci = number of info columns, r1/r2 = replicates per condition
   sjknull1 <- simulat(yy=jkttcell[1:500,], nci=7, r1=3, r2=3, p=0, q=0.2)
   ```
2. **Test Null Data**: Run `smbetattest` on these null sets.
   ```R
   mysim1 <- smbetattest(X=sjknull1, na=3, nb=3, alpha=0.05)
   ```
3. **Calculate $\omega$**: Identify the $\rho$ values of false positives. Sort them and choose a value where the FDR (q-value) is acceptable (typically the 10th largest $\rho$ or an average across simulations).

### 3. Normalization
Ensure all libraries have the same effective size. You can use `DESeq2` size factors or a simple library size scaling:
```R
# Simple scaling to mean library size
# NewCount = (OriginalCount * MeanLibrarySize) / SpecificLibrarySize
```

### 4. Multiple Beta t-Test on Real Data
Use `mbetattest` with your calculated $\omega$ (W).
```R
# W = calculated omega (e.g., 1.0)
res <- mbetattest(X=jkttcell, na=3, nb=3, W=1, alpha=0.05, file="results.csv")
```

## Visualization

### MA Plot
Displays t-values against log mean expression. Red points indicate significant differential expression.
```R
data(dat) # Example results
maplot(dat=dat, r1=3, r2=3, TT=50, matitle="MA Plot")
```

### Heatmap
Generates a publication-quality heatmap of significant genes.
```R
# tree options: "both", "row", "column", "none"
# method options: "euclidean", "pearson", "spearman", "kendall"
myheatmap(dat=dat, r1=3, r2=3, W=1, colrs="redgreen", tree="both", maptitle="DE Heatmap")
```

## Key Functions
- `mbetattest()`: Main function for real data analysis.
- `smbetattest()`: Used on simulated data to find $\omega$.
- `simulat()`: Generates negative binomial pseudo-random counts.
- `betaparametVP()`: Estimates beta distribution parameters (P and V).
- `mtprocedure()`: Adjusts alpha for multiple testing (BH, Bonferroni, etc.).

## Reference documentation
- [MBttest-manual](./references/MBttest-manual.md)
- [MBttest](./references/MBttest.md)