---
name: bioconductor-rnaseqsamplesize
description: This tool provides methods for sample size estimation and power analysis tailored for RNA-seq data using fixed parameters or reference distributions. Use when user asks to estimate sample size or power, utilize TCGA or custom pilot data distributions, perform pathway-specific power analysis, or optimize sequencing depth and replicate numbers.
homepage: https://bioconductor.org/packages/release/bioc/html/RnaSeqSampleSize.html
---


# bioconductor-rnaseqsamplesize

## Overview
The `RnaSeqSampleSize` package provides methods for sample size estimation and power analysis tailored for RNA-seq data. Unlike traditional methods that use conservative fixed values, this package leverages distributions of gene read counts and dispersions from real datasets (like TCGA) to provide more accurate estimates. It supports single-parameter estimation, distribution-based estimation, and optimization of sequencing depth versus replicate number.

## Core Workflows

### 1. Basic Power and Sample Size Estimation
Use these functions when you have specific fixed parameters for your study design.

```r
library(RnaSeqSampleSize)

# Estimate Power
# n: samples per group, rho: fold change, lambda0: avg reads, phi0: dispersion, f: FDR
est_power(n=63, rho=2, lambda0=5, phi0=0.5, f=0.01)

# Estimate Sample Size
# power: desired power (e.g., 0.8)
sample_size(power=0.8, rho=2, lambda0=5, phi0=0.5, f=0.01)
```

### 2. Estimation Using Reference Distributions
Use these functions to base your estimates on real-world data distributions. The package includes several TCGA datasets (e.g., "TCGA_READ", "TCGA_BRCA").

```r
# Power estimation using TCGA reference data
# repNumber: number of genes to randomly sample (use >= 100 for real analysis)
est_power_distribution(n=65, f=0.01, rho=2, distributionObject="TCGA_READ", repNumber=100)

# Sample size estimation using TCGA reference data
sample_size_distribution(power=0.8, f=0.01, distributionObject="TCGA_READ", repNumber=100)
```

### 3. Using Custom Prior Data
If you have your own pilot data, you can estimate the count and dispersion distributions first.

```r
# dataMatrix: genes in rows, samples in columns
# group: vector of 0 and 1 indicating groups
dist <- est_count_dispersion(dataMatrix, group=c(rep(0,5), rep(1,5)))

# Use the resulting object for power estimation
est_power_distribution(n=65, f=0.01, rho=2, distributionObject=dist, repNumber=100)
```

### 4. Targeted Estimation (Genes/Pathways)
You can restrict the power analysis to specific genes of interest or KEGG pathways.

```r
# By Gene List
genes <- c("A1BG", "A2M", "AAAS")
est_power_distribution(n=65, f=0.01, rho=2, distributionObject="TCGA_READ", selectedGenes=genes)

# By KEGG Pathway (e.g., "00010" for Glycolysis)
est_power_distribution(n=65, f=0.01, rho=2, distributionObject="TCGA_READ", pathway="00010")
```

### 5. Visualization and Optimization
Visualize the trade-offs between sample size and power, or optimize between depth and replicates.

```r
# Generate and plot power curves
res1 <- est_power_curve(n=63, f=0.01, rho=2, lambda0=5, phi0=0.5)
res2 <- est_power_curve(n=63, f=0.05, rho=2, lambda0=5, phi0=0.5)
plot_power_curve(list(res1, res2))

# Optimize parameters (e.g., varying n and sequencing depth lambda0)
opt_res <- optimize_parameter(fun=est_power, opt1="n", opt2="lambda0", 
                              opt1Value=c(3, 5, 10, 20), 
                              opt2Value=c(1, 5, 10, 20))
```

## Tips and Best Practices
*   **Replicates vs. Depth:** Use `optimize_parameter` to see the impact of adding more samples versus sequencing deeper. Generally, increasing replicates (n) has a larger impact on power than increasing read counts (lambda0) once a minimum depth is reached.
*   **repNumber:** In `_distribution` functions, the default `repNumber` is often small for speed. Always increase this to at least 100 (or 1000) for stable, publishable results.
*   **Dispersion (phi0):** If you don't have pilot data, 0.1 to 0.5 is a common range for human RNA-seq data, but using a `distributionObject` from a similar TCGA tissue type is more robust.

## Reference documentation
- [RnaSeqSampleSize](./references/RnaSeqSampleSize.md)