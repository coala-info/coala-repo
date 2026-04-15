---
name: bioconductor-ibmq
description: This package implements a hierarchical Bayesian model for large-scale eQTL mapping in datasets with many genes and SNPs but few individuals. Use when user asks to perform eQTL mapping, calculate posterior probabilities of association, identify significant eQTLs, classify associations as cis or trans, and detect eQTL hotspots.
homepage: https://bioconductor.org/packages/release/bioc/html/iBMQ.html
---

# bioconductor-ibmq

## Overview

The `iBMQ` package implements an integrated hierarchical Bayesian model designed for large-scale eQTL mapping. It is specifically optimized for the "large G (genes), large S (SNPs), small n (individuals)" paradigm. The model borrows strength across all gene expression data to improve mapping sensitivity and provides a natural way to control the False Discovery Rate (FDR) using Posterior Probabilities of Association (PPA).

## Data Preparation

The package requires specific data structures for analysis:

*   **Genotypes**: A `SnpSet` object.
    *   For Recombinant Inbred Strains (RIS): Code as 0 and 1.
    *   For F2 crosses: Code as 1, 2, or 3 (set `RIS = FALSE` in `eqtlMcmc`).
*   **Expression**: An `ExpressionSet` object. Rows must match the individuals in the genotype data.
*   **SNP Positions**: A data frame with columns: `SNP` (name), `Chr` (numeric), and `pos` (numeric bp).
*   **Gene Positions**: A data frame with columns: `Gene` (name), `Chr` (numeric), `start` (numeric bp), and `end` (numeric bp).

## Core Workflow

### 1. Run MCMC Mapping
The primary function `eqtlMcmc` computes the posterior probabilities. This is computationally intensive.

```r
library(iBMQ)
# For RIS data
PPA <- eqtlMcmc(snp_data, gene_data, n.iter=100000, burn.in=50000, n.sweep=20, mc.cores=6, RIS=TRUE)

# For F2 cross data
PPA_f2 <- eqtlMcmc(snp_f2, gene_f2, n.iter=100000, burn.in=50000, n.sweep=20, mc.cores=6, RIS=FALSE)
```

### 2. Thresholding and eQTL Identification
Calculate a PPA cutoff based on a desired FDR (e.g., 0.1 for 10%) and extract significant associations.

```r
# Calculate threshold for 10% FDR
cutoff <- calculateThreshold(PPA, 0.1)

# Find significant eQTLs
eqtl_results <- eqtlFinder(PPA, cutoff)
```

### 3. Classification (Cis vs Trans)
Classify eQTLs based on genomic distance. A common threshold is 1MB (1,000,000 bp).

```r
# eqtl_results: output from eqtlFinder
# snppos: SNP position data frame
# genepos: Gene position data frame
eqtl_classified <- eqtlClassifier(eqtl_results, snppos, genepos, 1000000)
```

### 4. Hotspot Detection
Identify SNPs linked to a high number of genes (trans-eQTL hotspots).

```r
# Find markers linked to more than 10 genes
hotspots <- hotspotFinder(eqtl_classified, 10)
```

## Visualization

Use `ggplot2` to create a genome-wide eQTL plot. A diagonal line represents cis-eQTLs, while vertical bands indicate trans-eQTL hotspots.

```r
library(ggplot2)
ggplot(eqtl_classified, aes(y=GeneStart, x=MarkerPosition)) +
  geom_point(aes(color = PPA), size = 1.5) +
  facet_grid(GeneChrm ~ MarkerChrm) +
  theme_bw() +
  scale_x_reverse()
```

## Tips and Requirements
*   **GSL Requirement**: The GNU Scientific Library (GSL) must be installed on the system for the package to compile/run.
*   **Parallelization**: Use the `mc.cores` argument in `eqtlMcmc` to utilize multiple processors (supported on Mac and Linux).
*   **Iteration Count**: For publication-quality results, use at least 100,000 iterations with a 50,000 burn-in.
*   **Memory**: Large datasets (thousands of genes/SNPs) require significant RAM; consider subsetting to the most variable genes if memory is an issue.

## Reference documentation
- [iBMQ](./references/iBMQ.md)