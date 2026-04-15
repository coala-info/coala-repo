---
name: bioconductor-icheck
description: This tool provides a quality control and statistical analysis pipeline for Illumina mRNA expression data. Use when user asks to identify outlying probes, detect batch effects, perform data normalization, or run differential expression analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/iCheck.html
---

# bioconductor-icheck

name: bioconductor-icheck
description: Quality control pipeline and data analysis for Illumina mRNA expression data. Use this skill to identify outlying gene probes, detect failed arrays, check for batch effects, perform data normalization, and run differential expression analysis using specialized wrappers for limma and GLM.

## Overview

The `iCheck` package provides a comprehensive suite of tools for the quality control (QC) and statistical analysis of high-dimensional Illumina mRNA expression data. It is designed to identify technical artifacts, batch effects, and biological outliers through visualization and automated filtering.

## Typical Workflow

### 1. Data Preparation
`iCheck` operates on `ExpressionSet` objects. Ensure your data includes necessary metadata in `phenoData` (e.g., `Pass_Fail`, `Batch_Run_Date`, `Subject_ID`).

```r
library(iCheck)
# Data should be an ExpressionSet object
# Example: es.raw
```

### 2. Initial Quality Control
Exclude arrays marked as technically failed and visualize QC probe trajectories.

```r
# Exclude failed arrays
es.raw <- es.raw[, es.raw$Pass_Fail == "pass"]

# Plot QC curves (e.g., biotin, housekeeping)
plotQCCurves(esQC = es.QC, probes = c("biotin"), projectName = "QC_Check")
```

### 3. Correlation and Batch Effect Analysis
Check squared correlations ($R^2$) among Genetic Control (GC) arrays or replicated samples to ensure consistency.

```r
# Heatmap of correlations for replicates
R2PlotFunc(es = es.raw, arrayType = "replicates", sortFlag = TRUE, 
           varSort = c("Subject_ID", "Batch_Run_Date"))

# Principal Component Analysis (PCA) to detect batch effects
pcaObj <- getPCAFunc(es = es.raw, requireLog2 = FALSE)
pca2DPlot(pcaObj = pcaObj, plot.dim = c(1,2), labelVariable = "Batch")
```

### 4. Distribution and Outlier Detection
Identify outlying probes or arrays using density plots, quantile plots, and the p95/p05 ratio.

```r
# Density plots for each array
densityPlots(es = es.raw, requireLog2 = FALSE)

# Quantile trajectories
quantilePlot(dat = exprs(es.raw), requireLog2 = FALSE)

# Identify bad arrays (p95/p05 ratio < 6)
plotSamplep95p05(es = es.raw, requireLog2 = FALSE, cut2 = 6)
```

### 5. Normalization
Pre-process data using background correction and normalization (often leveraging the `lumi` package).

```r
library(lumi)
es.q <- lumiN(es.raw, method = "quantile")
```

### 6. Statistical Analysis
Use wrappers to perform differential expression analysis.

*   **lmFitWrapper**: For unpaired data (limma-based).
*   **lmFitPaired**: For paired data.
*   **glmWrapper**: For general linear models (supports logistic regression).
*   **lkhrWrapper**: Likelihood ratio tests comparing full vs. reduced models.

```r
# Differential expression with limma wrapper
res.limma <- lmFitWrapper(es = es.q, formula = ~as.factor(Group), 
                          pos.var.interest = 1, pvalAdjMethod = "fdr")

# GLM for phenotype outcomes
res.glm <- glmWrapper(es = es.q, formula = Group ~ xi, 
                      family = gaussian, pos.var.interest = 1)
```

### 7. Result Visualization
Visualize top hits using boxplots or scatterplots to verify results aren't driven by outliers.

```r
# Parallel boxplots for top results
boxPlots(resFrame = res.limma$frame, es = es.q, nTop = 20, var.pheno = "Group")
```

## Tips and Best Practices
*   **Log Transformation**: Most functions have a `requireLog2` argument. Set this to `FALSE` if your data is already log-transformed or if you are using raw simulated data.
*   **Sorting**: Use `sortFlag = TRUE` and `varSort` in plotting functions to group arrays by batch or subject, making patterns easier to spot.
*   **GC Arrays**: Always exclude Genetic Control arrays (e.g., Hela) before performing final differential expression analysis on biological samples.

## Reference documentation
- [iCheck](./references/iCheck.md)