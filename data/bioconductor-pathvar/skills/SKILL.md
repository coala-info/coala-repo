---
name: bioconductor-pathvar
description: This tool analyzes gene expression variability at the pathway level to identify biological pathways with significant changes in variability compared to a reference or between experimental groups. Use when user asks to identify pathways with significant expression variability, compare variability distributions between two samples, or visualize pathway-specific variability using metrics like SD, MAD, and CV.
homepage: https://bioconductor.org/packages/3.6/bioc/html/pathVar.html
---

# bioconductor-pathvar

name: bioconductor-pathvar
description: Analysis of gene expression variability at the pathway level using the pathVar Bioconductor package. Use this skill to identify pathways with significant changes in expression variability (SD, MAD, CV) for one-sample or two-sample comparisons, cluster genes by variability, and visualize pathway-specific variability distributions.

# bioconductor-pathvar

## Overview

The `pathVar` package is designed to analyze biological pathway variability rather than just mean expression. It allows users to determine if a pathway has an unusual distribution of gene variability (e.g., an enrichment of highly variable genes) compared to the global genomic background or between two experimental groups. It supports standard deviation (SD), median absolute deviation (MAD), and coefficient of variation (CV) as metrics.

## Typical Workflow

### 1. Data Preparation and Diagnostics
Before analysis, determine which variability statistic is least correlated with the mean for your specific dataset.

```r
library(pathVar)
# One sample diagnostics
diagnosticsVarPlots(data_matrix)

# Two sample diagnostics
groups <- as.factor(c(rep(1, 10), rep(2, 10)))
diagnosticsVarPlotsTwoSample(data_matrix, groups = groups)
```

### 2. One-Sample Analysis
Compare the variability distribution of genes within a pathway against the global distribution of all genes in the dataset.

```r
# Run analysis using KEGG pathways and Chi-squared test
resOneSam <- pathVarOneSample(data_matrix, pways.kegg, test = "chisq", varStat = "sd")

# Identify significant pathways (p < 0.05)
sigOneSam <- sigPway(resOneSam, 0.05)

# View significant pathways and their categories
resOneSam@tablePway
```

### 3. Two-Sample Analysis
Compare variability distributions between two groups (e.g., Case vs. Control).

**Continuous Approach (Density-based):**
Uses a bootstrapped Kolmogorov-Smirnov test to compare variability densities.
```r
resTwoSamCont <- pathVarTwoSamplesCont(data_matrix, pways.kegg, groups = groups, varStat = "sd")
sigTwoSamCont <- sigPway(resTwoSamCont, 0.05)
```

**Discrete Approach (Count-based):**
Clusters genes into low, medium, and high variability bins and compares counts using Chi-squared or Exact tests.
```r
resTwoSamDisc <- pathVarTwoSamplesDisc(data_matrix, pways.kegg, groups = groups, test = "exact", varStat = "sd")
sigTwoSamDisc <- sigPway(resTwoSamDisc, 0.05)
```

### 4. Visualization and Gene Extraction
Visualize results for specific pathways and extract genes falling within specific variability ranges.

```r
# Plot a specific pathway
plotPway(resOneSam, "ECM-receptor interaction", sigOneSam)

# Extract genes from a specific variability window in two-sample density
genes_in_window <- getGenes(resTwoSamCont, "Oxidative phosphorylation", c(0.25, 0.6))
# Access gene lists
genes_in_window@genes1
genes_in_window@genes2
```

## Key Functions

- `pathVarOneSample`: Compares pathway variability to the global reference.
- `pathVarTwoSamplesCont`: Compares variability densities between two groups.
- `pathVarTwoSamplesDisc`: Compares variability category counts between two groups.
- `sigPway`: Filters results for significance and identifies significant variability categories.
- `plotPway`: Generates histograms (one-sample/discrete) or density plots (continuous) for a pathway.
- `makeDBList`: Formats custom pathway lists for use with the package.
- `getGenes`: Retrieves gene names from specific variability intervals in two-sample continuous results.

## Reference documentation

- [How to use the pathVar package](./references/pathVar.md)